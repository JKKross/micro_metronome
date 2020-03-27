//
//  TopControlsBar.swift
//  metronome
//
//  Created by Jan Kříž on 19/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct TopControlsBar: View {

	@EnvironmentObject var audioController: AudioController

	var body: some View {
		HStack {
			Button(action: {
				if self.audioController.bpm > self.audioController.minBPM { self.audioController.bpm -= 1 }
			}) { Image(systemName: "minus") }
			.buttonStyle(CustomButtonStyle(size: 55))
			.font(.system(size: 40))
			.accessibility(label: Text("minus 1 bpm"))
			.padding(12)
			.hoverEffect(.highlight)

			Text("\(audioController.bpm)")
			.font(Font.custom("Futura", size: 65))
			.foregroundColor(Color("text"))
			.accessibility(label: Text("Current bpm: \(audioController.bpm)"))
			.frame(width: 125, height: 1)

			Button(action: {
				if self.audioController.bpm < self.audioController.maxBPM { self.audioController.bpm += 1 }
			}) { Image(systemName: "plus") }
			.buttonStyle(CustomButtonStyle(size: 55))
			.font(.system(size: 40))
			.accessibility(label: Text("plus 1 bpm"))
			.padding(12)
			.hoverEffect(.highlight)
		}
	}
}
