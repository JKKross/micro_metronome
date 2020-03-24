//
//  BottomControlsBar.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct BottomControlsBar: View {

	@EnvironmentObject var audioController: AudioController
	@State private var isShowingSettingsView = false
	@State private var tapTimeStamps: Array<Date> = Array()

	var body: some View {

		HStack {
			Button(action: {
				self.tapTimeStamps.removeAll()
				self.isShowingSettingsView = true
			}) { Image(systemName: "gear") }
			.sheet(isPresented: $isShowingSettingsView) { SettingsView(selectedSound: self.$audioController.selectedSound, isOnScreen: self.$isShowingSettingsView) }
			.buttonStyle(CustomButtonStyle(size: 65))
			.font(.system(size: 35))
			.accessibility(label: Text("Settings"))

			Button(action: {
				if self.audioController.isPlaying {
					self.audioController.stop()
					// We want to prepare the buffer here, otherwise it will start playing from where
					// the the user stopped it, which may start with silence & sound weird
					self.audioController.prepareBuffer()
				} else {
					self.audioController.play()
				}
				
				self.tapTimeStamps.removeAll()
				self.audioController.isPlaying.toggle()
			}) {
				Image(systemName: audioController.isPlaying ? "pause" : "play")
				.offset(x: audioController.isPlaying ? 0 : 3)
				.foregroundColor(audioController.isPlaying ? Color("highlight_2") : Color("highlight"))
				}
			.buttonStyle(CustomButtonStyle(size: 80))
			.font(.system(size: 55))
			.accessibility(label: audioController.isPlaying ? Text("pause") : Text("play"))
			.frame(width: 150)

			Button(action: {
				let d = Date()
				self.tapTimeStamps.append(d)
				guard self.tapTimeStamps.count > 2 else { return }
				
				var timeIntervals: Array<TimeInterval> = []
				
				for i in 0..<(self.tapTimeStamps.count - 1) {
					let ti = DateInterval(start: self.tapTimeStamps[i], end: self.tapTimeStamps[i + 1])
					timeIntervals.append(ti.duration)
				}
				
				var sum = 0.0
				for i in timeIntervals { sum += i }
				let guessedBPM = Int(60 / (sum / Double(timeIntervals.count)))
				
				if self.audioController.isPlaying {
					self.audioController.stop()
					self.audioController.isPlaying = false
				}
				
				if guessedBPM > self.audioController.maxBPM {
					self.audioController.bpm = self.audioController.maxBPM
				} else if guessedBPM < self.audioController.minBPM {
					self.audioController.bpm = self.audioController.minBPM
				} else {
					self.audioController.bpm = guessedBPM
				}
				if self.tapTimeStamps.count > 5 { self.tapTimeStamps.removeAll() }
				
			}) { Text("Tap") }
			.buttonStyle(CustomButtonStyle(size: 65))
			.font(.system(size: 25, weight: .bold))
			.lineLimit(1)
			.frame(width: 60, height: 60, alignment: .center)
			.accessibility(label: Text("Tap to set tempo"))
		}
	}

}
