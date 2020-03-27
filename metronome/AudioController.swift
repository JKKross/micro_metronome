//
//  AudioController.swift
//  metronome
//
//  Created by Jan Kříž on 01/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import AVFoundation
import MediaPlayer

public enum Sounds: String {
	case rimshot             = "Rimshot"
	case bassDrum            = "Bass drum"
	case clap                = "Clap"
	case cowbell             = "Cowbell"
	case hiHat               = "Hi-hat"
	case mechanicalMetronome = "Mechanical Metronome"
	case hjonk               = "Hjonk"
	case jackSlap            = "Jack slap"
	case laugh               = "LAUGH!"
}

public final class AudioController: ObservableObject {

	public let minBPM = 20
	public let maxBPM = 300

	@Published public var isPlaying = false
	@Published public var bpm = 100

	@Published public var selectedSound: Sounds = .rimshot {
		willSet {
			if self.isPlaying { self.stop() }
			self.loadFile(newValue)
			self.prepareBuffer()
			if self.isPlaying { self.play() }
		}
	}

	private let audioSession = AVAudioSession.sharedInstance()
	private let settings = UserSettings()

	private var soundFileURL: URL!
	private var originalAiffBuffer: Array<UInt8>!
	private var aiffBuffer: Array<UInt8>!
	private var player: AVAudioPlayer!

	public init() {
		self.bpm = settings.getBPM()
		self.selectedSound = settings.getPreferredSound()

		self.loadFile(self.selectedSound)
		self.prepareBuffer()

		do {
			try audioSession.setCategory(.playback, mode: .default, options: [])
			try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
		} catch {
			debugPrint("Could not set-up audioSession:", error)
		}

		// Make the play/pause functionality available in control center &
		// with headphones play/pause button
		let mp = MPRemoteCommandCenter.shared()

		mp.playCommand.isEnabled = true
		mp.playCommand.addTarget { _ in
			if !self.isPlaying {
				self.player.play()
				self.isPlaying = true
				return .success
			}
			return .commandFailed
		}

		mp.pauseCommand.isEnabled = true
		mp.pauseCommand.addTarget { _ in
			if self.isPlaying {
				self.player.stop()
				self.isPlaying = false
				return .success
			}
			return .commandFailed
		}

		UIApplication.shared.beginReceivingRemoteControlEvents()
	}

	deinit {
		player.stop()
		do {
			try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
		} catch {
			debugPrint("Could not deactivate audioSession:", error)
		}
	}

	public func saveSelectedSoundAndCurrentBPM() {
		settings.save(bpm: self.bpm)
		settings.save(preferredSound: self.selectedSound)
	}

	public func play() {
		player.play()
	}

	public func stop() {
		player.stop()
	}

	public func prepareBuffer() {
		aiffBuffer = Transform(aiffSoundFile: originalAiffBuffer, to: self.bpm)

		do {
			let soundData = Data(aiffBuffer)
			self.player = try AVAudioPlayer(data: soundData, fileTypeHint: "public.aiff-audio")
			player.numberOfLoops = -1
			player.prepareToPlay()
		} catch {
			fatalError("Could not init AVAudioPlayer: \(error)")
		}
	}

	private func loadFile(_ selectedSound: Sounds) {
		if let path = Bundle.main.path(forResource: "\(selectedSound.rawValue).aif", ofType: nil) {
			self.soundFileURL = URL(fileURLWithPath: path)
		} else {
			fatalError("Could not create url for \(selectedSound.rawValue).aif")
		}

		do {
			let soundData = try Data(contentsOf: soundFileURL)
			originalAiffBuffer = Array(soundData[0..<soundData.endIndex])
			aiffBuffer = originalAiffBuffer
		} catch {
			fatalError("DATA READING ERROR: \(error)")
		}
	}

}


/// Transforms given AIFF file to desired bpm.
///
/// - Parameter data: AIFF file (as bytes) which represents exactly 3 seconds long (20 bpm) sound. If the sound has any other duration than 20 bpm, result is undefined.
/// - Parameter bpm: What bpm to transform the sound into. Must be >= 20, crashes otherwise.
///
/// - Returns: Array of bytes representing new AIFF file of desired bpm.
///
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
