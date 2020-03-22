//
//  KeyboardAwareUIHostingController.swift
//  metronome
//
//  Created by Jan Kříž on 22/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import UIKit
import SwiftUI

class KeyboardAwareUIHostingController<Content>: UIHostingController<Content> where Content: View {
	
	private let audioController: AudioController

	private let keys = [
		UIKeyCommand(input: " ", modifierFlags: [], action: #selector(playPause)),
		UIKeyCommand(input: "+", modifierFlags: [], action: #selector(plusOneBPM)),
		UIKeyCommand(input: "-", modifierFlags: [], action: #selector(minusOneBPM)),
		UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(plusOneBPM)),
		UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(minusOneBPM)),
		UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [.command], action: #selector(plusTenBPM)),
		UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [.command], action: #selector(minusTenBPM)),
		UIKeyCommand(input: "+", modifierFlags: [.command], action: #selector(plusTenBPM)),
		UIKeyCommand(input: "-", modifierFlags: [.command], action: #selector(minusTenBPM)),
	]

	override var keyCommands: [UIKeyCommand]? {
		keys[0].title = "Play/Pause"
		// no need for info about + & - keys
		keys[3].title = "+1 bpm"
		keys[4].title = "-1 bpm"
		keys[5].title = "+10 bpm"
		keys[6].title = "-10 bpm"

		return keys
	}
	
	public init(view: Content, audioController: AudioController) {
		self.audioController = audioController
		super.init(rootView: view)
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func becomeFirstResponder() -> Bool {
		true
	}
	
	@objc func playPause() {
		if audioController.isPlaying {
			audioController.stop()
		} else {
			audioController.play()
		}
		
		audioController.isPlaying.toggle()
	}

	@objc func plusOneBPM() {
		if audioController.isPlaying {	audioController.stop() }
		if audioController.bpm < 260 {
			audioController.bpm += 1
		}
		audioController.prepareBuffer()
		if audioController.isPlaying { audioController.play() }
	}

	@objc func minusOneBPM() {
		if audioController.isPlaying {	audioController.stop() }
		if audioController.bpm > 20 {
			audioController.bpm -= 1
		}
		audioController.prepareBuffer()
		if audioController.isPlaying { audioController.play() }
	}
	
	@objc func plusTenBPM() {
		if audioController.isPlaying {	audioController.stop() }
		if audioController.bpm <= 250 {
			audioController.bpm += 10
		} else {
			audioController.bpm = 260
		}
		audioController.prepareBuffer()
		if audioController.isPlaying { audioController.play() }
	}

	@objc func minusTenBPM() {
		if audioController.isPlaying {	audioController.stop() }
		if audioController.bpm >= 30 {
			audioController.bpm -= 10
		} else {
			audioController.bpm = 20
		}
		audioController.prepareBuffer()
		if audioController.isPlaying { audioController.play() }
	}
}
