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

	private var alreadyPressedKeys: Array<Int> = []

	private let keys = [
		UIKeyCommand(input: " ", modifierFlags: [], action: #selector(playPause)),
		UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(plusOneBPM)),
		UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(minusOneBPM)),
		UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [.command], action: #selector(plusTenBPM)),
		UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [.command], action: #selector(minusTenBPM)),
		
		UIKeyCommand(input: "0...9 + ⏎", modifierFlags: [], action: #selector(doNothing)),
		
		UIKeyCommand(input: "+", modifierFlags: [], action: #selector(plusOneBPM)),
		UIKeyCommand(input: "-", modifierFlags: [], action: #selector(minusOneBPM)),
		UIKeyCommand(input: "+", modifierFlags: [.command], action: #selector(plusTenBPM)),
		UIKeyCommand(input: "-", modifierFlags: [.command], action: #selector(minusTenBPM)),

		UIKeyCommand(input: "0", modifierFlags: [], action: #selector(pressedZero)),
		UIKeyCommand(input: "1", modifierFlags: [], action: #selector(pressedOne)),
		UIKeyCommand(input: "2", modifierFlags: [], action: #selector(pressedTwo)),
		UIKeyCommand(input: "3", modifierFlags: [], action: #selector(pressedThree)),
		UIKeyCommand(input: "4", modifierFlags: [], action: #selector(pressedFour)),
		UIKeyCommand(input: "5", modifierFlags: [], action: #selector(pressedFive)),
		UIKeyCommand(input: "6", modifierFlags: [], action: #selector(pressedSix)),
		UIKeyCommand(input: "7", modifierFlags: [], action: #selector(pressedSeven)),
		UIKeyCommand(input: "8", modifierFlags: [], action: #selector(pressedEight)),
		UIKeyCommand(input: "9", modifierFlags: [], action: #selector(pressedNine)),
		UIKeyCommand(input: "\r", modifierFlags: [], action: #selector(pressedEnter)),
		UIKeyCommand(input: "\r", modifierFlags: [.shift], action: #selector(pressedEnter)),
	]

	override var keyCommands: [UIKeyCommand]? {
		keys[0].title = "Play/Pause"
		keys[1].title = "+1 bpm"
		keys[2].title = "-1 bpm"
		keys[3].title = "+10 bpm"
		keys[4].title = "-10 bpm"
		keys[5].title = "Type your desired tempo & set it with ⏎"

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
	
	@objc func doNothing() {
		//
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
		if audioController.bpm < audioController.maxBPM { audioController.bpm += 1 }
	}

	@objc func minusOneBPM() {
		if audioController.bpm > audioController.minBPM { audioController.bpm -= 1 }
	}

	@objc func plusTenBPM() {
		if audioController.bpm <= (audioController.maxBPM - 10) {
			audioController.bpm += 10
		} else {
			audioController.bpm = audioController.maxBPM
		}
		// just a hack to trigger the .onReceive modifier on BPMSlider
		// No idea why it's not working properly
		audioController.bpm += 1
		audioController.bpm -= 1
	}

	@objc func minusTenBPM() {
		if audioController.bpm >= (audioController.minBPM + 10) {
			audioController.bpm -= 10
		} else {
			audioController.bpm = audioController.minBPM
		}
		// just a hack to trigger the .onReceive modifier on BPMSlider
		// No idea why it's not working properly
		audioController.bpm += 1
		audioController.bpm -= 1
	}

	@objc func pressedEnter() {
		if alreadyPressedKeys.count >= 2 {
			setBpmFromAlreadyPressedKeys()
		}
		alreadyPressedKeys.removeAll()
	}

	@objc func pressedZero() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(0)
		}
	}

	@objc func pressedOne() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(1)
		}
	}

	@objc func pressedTwo() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(2)
		}
	}

	@objc func pressedThree() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(3)
		}
	}

	@objc func pressedFour() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(4)
		}
	}

	@objc func pressedFive() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(5)
		}
	}

	@objc func pressedSix() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(6)
		}
	}

	@objc func pressedSeven() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(7)
		}
	}

	@objc func pressedEight() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(8)
		}
	}

	@objc func pressedNine() {
		if alreadyPressedKeys.count == 3 {
			setBpmFromAlreadyPressedKeys()
		} else {
			alreadyPressedKeys.append(9)
		}
	}

	private func setBpmFromAlreadyPressedKeys() {

		let bpm: Int = {
			switch alreadyPressedKeys.count {
			case 2:
				return (alreadyPressedKeys[0] * 10) + alreadyPressedKeys[1]
			case 3:
				return (alreadyPressedKeys[0] * 100) + (alreadyPressedKeys[1] * 10) + alreadyPressedKeys[2]
			default:
				fatalError("alreadyPressedKeys array count was messed up. This should not happen!")
			}
		}()

		if bpm >= audioController.maxBPM {
			audioController.bpm = audioController.maxBPM
		} else if bpm <= audioController.minBPM {
			audioController.bpm = audioController.minBPM
		} else {
			audioController.bpm = bpm
		}

		alreadyPressedKeys.removeAll()
		
		// just a hack to trigger the .onReceive modifier on BPMSlider
		// No idea why it's not working properly
		audioController.bpm += 1
		audioController.bpm -= 1
	}

}
