//
//  AudioEngine.swift
//  MetronomeKit
//
//  Created by Jan Kříž on 31/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import AVFoundation


public final class AudioEngine {

	private var player: AVAudioPlayer!

	public init() {}

	public func prepareToPlay(aiffBuffer: Array<UInt8>, bpm: Int) {
		let aiffBuffer = Transform(aiffSoundFile: aiffBuffer, to: bpm)

		do {
			let soundData = Data(aiffBuffer)
			self.player = try AVAudioPlayer(data: soundData, fileTypeHint: "public.aiff-audio")
			player.numberOfLoops = -1
			player.prepareToPlay()
		} catch {
			fatalError("Could not init AVAudioPlayer: \(error)")
		}
	}

	public func play() {
		self.player.play()
	}

	public func stop() {
		self.player.stop()
		self.player.prepareToPlay()
	}

}

/**
	Transforms given AIFF file to desired bpm.

	- Parameter data: AIFF file (as bytes) which represents exactly 3 seconds long (20 bpm) sound. If the sound has any other duration than 20 bpm, result is undefined.
	- Parameter bpm: What bpm to transform the sound into. Must be >= 20, crashes otherwise.

	- Returns: Array of bytes representing new AIFF file of desired bpm.
*/
fileprivate func Transform(aiffSoundFile data: Array<UInt8>, to bpm: Int) -> Array<UInt8> {
	guard bpm >= 20 else { fatalError("Attempt to transform an AIFF file to less than 20 bpm.") }
	if bpm == 20 { return data }

	let originalFileBPM = 20
	var aiffBuffer = data
	var index = 0
	// 529_208 is the size of the sound chunk (in bytes).
	// Since we know that those bytes represent 20 bpm, we can get the number of bytes
	// to subtract from it with this formula to get the sound of desired length.
	var sizeToSubtract = Int32(529_208 - (529_208 * originalFileBPM / bpm))

	if sizeToSubtract % 2 != 0 { sizeToSubtract += 1 }

	// Divide by 4 because one sample frame is 32-bits wide (Two 16-bit floats, one for each channel)
	let numSampleFramesToSubtract = UInt32(sizeToSubtract / 4)

	while index < aiffBuffer.count {
		// To figure out what's going on here, read through the AIFF specification:
		// http://www-mmsp.ece.mcgill.ca/Documents/AudioFormats/AIFF/Docs/AIFF-1.3.pdf
		guard let ckID = String(bytes: aiffBuffer[index...(index + 3)], encoding: .utf8) else {
			fatalError("Could not read ckID. current index: \(index)")
		}
		index += 4

		if ckID == "FORM" {
			let ptr = UnsafeMutableRawPointer(&aiffBuffer[index])
			let safePtr = ptr.assumingMemoryBound(to: Int32.self)
			// Update ckSize to reflect the new length of the sound chunk
			let ckSize = Int32(bigEndian: safePtr.pointee) - sizeToSubtract
			safePtr.pointee = Int32(bigEndian: ckSize)
			// Skip right to the beginning of the next chunk
			index += 8
			continue
		} else if ckID == "COMM" {
			let ptr = UnsafeMutableRawPointer(&aiffBuffer[index + 6])
			let safePtr = ptr.assumingMemoryBound(to: UInt32.self)
			// update numSampleFrames to reflect new length of the sound chunk
			let numSampleFrames = UInt32(bigEndian: safePtr.pointee) - numSampleFramesToSubtract
			safePtr.pointee = UInt32(bigEndian: numSampleFrames)
		} else if ckID == "SSND" {
			let ptr = UnsafeMutableRawPointer(&aiffBuffer[index])
			let safePtr = ptr.assumingMemoryBound(to: Int32.self)
			let originalSize = Int32(bigEndian: safePtr.pointee)
			// Update ckSize to reflect the new length of the sound chunk
			let ckSize = originalSize - sizeToSubtract
			safePtr.pointee = Int32(bigEndian: ckSize)

			let lowerBound = index + 8 + Int(ckSize)
			let upperBound = index + 8 + Int(originalSize)
			aiffBuffer.removeSubrange(lowerBound..<upperBound)
			break
		}

		let ptr = UnsafeRawPointer(&aiffBuffer[index])
		let ckSize = Int32(bigEndian: ptr.assumingMemoryBound(to: Int32.self).pointee)
		index += 4 + Int(ckSize)
	}

	return aiffBuffer
}
