//
//  MasterController.swift
//  metronome
//
//  Created by Jan Kříž on 01/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import MediaPlayer
import MetronomeKit


public enum Sounds: String {
	case rimshot             = "Rimshot"
	case bassDrum            = "Bass drum"
	case clap                = "Clap"
	case cowbell             = "Cowbell"
	case hiHat               = "Hi-hat"
	case mechanicalMetronome = "Mechanical metronome"
	case hjonk               = "Hjonk"
	case jackSlap            = "Jack slap"
	case laugh               = "LAUGH!"
}


public final class MasterController: ObservableObject {

	public let minBPM = 20
	public let maxBPM = 300

	@Published public var isPlaying = false
	@Published public var bpm = 100 {
		didSet {
			self.prepareBuffer()
		}
	}

	@Published public var totalHoursPracticedSoFar = 0
	@Published public var totalMinutesPracticedSoFar = 0

	@Published public var selectedSound: Sounds = .rimshot {
		didSet {
			if self.isPlaying { self.engine.stop() }
			self.loadFile(self.selectedSound)
			self.prepareBuffer()
			if self.isPlaying { self.engine.play() }
		}
	}

	private let settings = UserSettings()
	private var startedPracticeTime = Date()
	private let engine = AudioEngine()
	
	private var soundFileURL: URL!
	private var aiffBuffer: Array<UInt8>!

	public init() {
		self.selectedSound = settings.getPreferredSound()
		self.bpm = settings.getBPM()

		let (hours, minutes) = settings.getHoursAndMinutes()

		self.totalHoursPracticedSoFar = hours
		self.totalMinutesPracticedSoFar = minutes

		// Make the play/pause functionality available in control center &
		// with headphones play/pause button
		let mp = MPRemoteCommandCenter.shared()

		mp.playCommand.isEnabled = true
		mp.playCommand.addTarget { _ in
			if !self.isPlaying {
				self.engine.play()
				self.isPlaying = true
				return .success
			}
			return .commandFailed
		}

		mp.pauseCommand.isEnabled = true
		mp.pauseCommand.addTarget { _ in
			if self.isPlaying {
				self.engine.stop()
				self.isPlaying = false
				return .success
			}
			return .commandFailed
		}

		UIApplication.shared.beginReceivingRemoteControlEvents()
	}


	public func saveStuff() {
		settings.save(bpm: self.bpm)
		settings.save(preferredSound: self.selectedSound)
		self.settings.save(hours: self.totalHoursPracticedSoFar, minutes: self.totalMinutesPracticedSoFar)
	}

	public func play() {
		self.engine.play()
		self.startedPracticeTime = Date()
	}

	public func stop() {
		self.engine.stop()

		let endedPracticeTime = Date()
		let ti = DateInterval(start: self.startedPracticeTime, end: endedPracticeTime)
		let seconds = Int(ti.duration + 0.5)

		// The + 20 here is just a little bump that feels adequate to me.
		// If the user turns off the metronome at 11 minutes 40 seconds, they get 12 minutes instead.
		let newMinutes = (seconds + 20) / 60
		self.totalMinutesPracticedSoFar += newMinutes

		// If totalMinutesPracticedSoFar if < 1 hour, nothing happens.
		// Else if it is > 1 hour, than these two lines should work correctly.
		self.totalHoursPracticedSoFar += self.totalMinutesPracticedSoFar / 60
		self.totalMinutesPracticedSoFar = self.totalMinutesPracticedSoFar % 60

		self.settings.save(hours: self.totalHoursPracticedSoFar, minutes: self.totalMinutesPracticedSoFar)
	}

	public func prepareBuffer() {
		self.engine.prepareToPlay(aiffBuffer: self.aiffBuffer, bpm: self.bpm)
	}

	private func loadFile(_ fileName: Sounds) {
		if let path = Bundle.main.path(forResource: "\(selectedSound.rawValue).aif", ofType: nil) {
			self.soundFileURL = URL(fileURLWithPath: path)
		} else {
			fatalError("Could not create url for \(selectedSound.rawValue).aif")
		}

		do {
			let soundData = try Data(contentsOf: soundFileURL)
			self.aiffBuffer = Array(soundData[0..<soundData.endIndex])
		} catch {
			fatalError("DATA READING ERROR: \(error)")
		}
	}

}


