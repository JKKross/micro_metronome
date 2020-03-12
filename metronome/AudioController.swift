//
//  AudioController.swift
//  metronome
//
//  Created by Jan Kříž on 01/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import AVFoundation

final class AudioController: ObservableObject {

	@Published public var isPlaying = false
	@Published public var bpm = 300

	private let soundFileURL: URL
	private let origialAiffBuffer: Array<UInt8>
	private var aiffBuffer: Array<UInt8>
	private var soundData: Data
	private var player: AVAudioPlayer!

	public init() {
		if let path = Bundle.main.path(forResource: "rimshot.aif", ofType: nil) {
			self.soundFileURL = URL(fileURLWithPath: path)
		} else {
			fatalError("Could not create url for rimshot.aif")
		}

		do {
			self.soundData = try Data(contentsOf: soundFileURL)
			origialAiffBuffer = Array(soundData[0..<soundData.endIndex])
			aiffBuffer = Array()
			aiffBuffer.reserveCapacity(530_000)
		} catch {
			fatalError("DATA READING ERROR: \(error)")
		}

		self.prepareBuffer()
	}

	public func play() {
		player.play()
	}

	public func stop() {
		player.stop()
	}

	public func prepareBuffer() {
		print("\n***** PREPARING BUFFER *****\n")
		defer { print("aiffBuffer.count: \(aiffBuffer.count) \n\n***** BUFFER PREPARATION COMPLETE *****\n") }
		print("BPM set to \(self.bpm)\n")

		aiffBuffer = origialAiffBuffer

		defer { player.numberOfLoops = -1; player.prepareToPlay() }

		var index = 0

		var sizeToAdd: Int32 = Int32((35_288 * 300 / self.bpm) - 35_288)

 		if sizeToAdd % 2 != 0 { sizeToAdd += 1 }

		// Divide by 4 because one sample frame if 32-bits wide (Two 16-bit floats, one for each channel)
		let numSampleFramesToAdd: UInt32 = UInt32(sizeToAdd / 4)

		while self.bpm != 300 && index < aiffBuffer.count {
			guard let ckID = String(bytes: aiffBuffer[index...(index + 3)], encoding: .utf8) else {
				fatalError("Could not read ckID. current index: \(index)")
			}
			print("ckID: \(ckID), current index: \(index)")
			index += 4

			if ckID == "FORM" {
				// Update ckSize to reflect the new length of the sound chunk
				let ptr = UnsafeMutableRawPointer(&aiffBuffer[index])
				let safePtr = ptr.assumingMemoryBound(to: Int32.self)
				let size = Int32(bigEndian: safePtr.pointee) + sizeToAdd
				safePtr.pointee = Int32(bigEndian: size)
				// next line is for debug only, delete when finished
				print("Updated size of FORM: \(Int32(bigEndian: safePtr.pointee))")
				// Skip right to the beginning of the next chunk
				index += 8
				continue
			} else if ckID == "COMM" {
				// update numSampleFrames to reflect new length of the sound chunk
				let ptr = UnsafeMutableRawPointer(&aiffBuffer[index + 6])
				let safePtr = ptr.assumingMemoryBound(to: UInt32.self)
				let numSampleFrames = UInt32(bigEndian: safePtr.pointee) + numSampleFramesToAdd
				safePtr.pointee = UInt32(bigEndian: numSampleFrames)
				// next line is for debug only, delete when finished
				print("Updated numSampleFrames of COMM: \(UInt32(bigEndian: safePtr.pointee))")
			} else if ckID == "SSND" {
				let ptr = UnsafeMutableRawPointer(&aiffBuffer[index])
				let safePtr = ptr.assumingMemoryBound(to: Int32.self)
				let size = Int32(bigEndian: safePtr.pointee) + sizeToAdd
				safePtr.pointee = Int32(bigEndian: size)

				// next line is for debug only, delete when finished
				print("Updated ckSize of SSND: \(Int32(bigEndian: safePtr.pointee))")

				let bytesToAdd: Array<UInt8> = Array(repeating: 0, count: Int(sizeToAdd))
				aiffBuffer.insert(contentsOf: bytesToAdd, at: index + 8)
				break
			}

			let ptr = UnsafeRawPointer(&aiffBuffer[index])
			let ckSize = Int32(bigEndian: ptr.assumingMemoryBound(to: Int32.self).pointee)
			index += 4 + Int(ckSize)
			print("ckSize: \(ckSize), next index: \(index)")

		}

		do {
			self.soundData = Data(aiffBuffer)
			self.player = try AVAudioPlayer(data: soundData, fileTypeHint: "public.aiff-audio")
		} catch {
			fatalError("Could not init AVAudioPlayer: \(error)")
		}
	}

}
