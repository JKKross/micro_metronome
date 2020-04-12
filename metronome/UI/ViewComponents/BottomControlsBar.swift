//
//  BottomControlsBar.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct BottomControlsBar: View {
	
	@EnvironmentObject var controller: MasterController
	
	@State private var isShowingSettingsView = false
	@State private var tapTimeStamps: Array<Date> = Array()
	
	var body: some View {
		
		HStack {
			Button(action: {
				self.tapTimeStamps.removeAll()
				self.isShowingSettingsView = true
			}) { Image(systemName: "gear") }
				.sheet(isPresented: $isShowingSettingsView) { SettingsView(isOnScreen: self.$isShowingSettingsView).environmentObject(self.controller) }
				.buttonStyle(CustomButtonStyle(size: 65))
				.font(.system(size: 35))
				.accessibility(label: Text("Settings"))
				.frame(width: 70, height: 70)
				.hoverEffect(.highlight)
			
			Button(action: {
				if self.controller.isPlaying {
					self.controller.stop()
					// We want to prepare the buffer here, otherwise it will start playing from where
					// the the user stopped it, which may start with silence & sound weird
					self.controller.prepareBuffer()
				} else {
					self.controller.play()
				}
				
				self.tapTimeStamps.removeAll()
				self.controller.isPlaying.toggle()
			}) {
				Image(systemName: controller.isPlaying ? "pause" : "play")
					.offset(x: controller.isPlaying ? 0 : 3)
					.foregroundColor(controller.isPlaying ? Color("highlight_2") : Color("highlight"))
			}
			.buttonStyle(CustomButtonStyle(size: 80))
			.font(.system(size: 55))
			.accessibility(label: controller.isPlaying ? Text("pause") : Text("play"))
			.frame(width: 110, height: 110)
			.hoverEffect(.highlight)
			
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
				
				if self.controller.isPlaying {
					self.controller.stop()
					self.controller.isPlaying = false
				}
				
				self.controller.setBPM(guessedBPM)
				if self.tapTimeStamps.count > 5 { self.tapTimeStamps.removeAll() }
				
			}) { Text("Tap") }
				.buttonStyle(CustomButtonStyle(size: 65))
				.font(.system(size: 25, weight: .bold))
				.lineLimit(1)
				.accessibility(label: Text("Tap to set tempo"))
				.frame(width: 70, height: 70)
				.hoverEffect(.highlight)
		}
	}
	
}
