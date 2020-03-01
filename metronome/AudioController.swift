//
//  AudioController.swift
//  metronome
//
//  Created by Jan Kříž on 01/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import AVFoundation

final class AudioController: ObservableObject {

	@Published public var bpm = 90

	private let player: AVAudioPlayer
	private let rimshotURL: URL

	public init() {
		if let path = Bundle.main.path(forResource: "rimshot.aif", ofType: nil) {
			print("PATH:", path)
			self.rimshotURL = URL(fileURLWithPath: path)
		} else {
			fatalError("Could not create url for rimshot.aif")
		}

		do {
			self.player = try AVAudioPlayer(contentsOf: rimshotURL)
		} catch {
			fatalError("Could not properly initialize AVAudioPlayer. Error message: \(error)")
		}

		player.numberOfLoops = -1
		player.prepareToPlay()
	}

	public func play() {
		player.play()
	}

	public func stop() {
		player.stop()
	}
}
