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

			Button(action: { self.audioController.bpm -= 1 }) { Image(systemName: "minus") }
			.buttonStyle(CustomButtonStyle(size: 45))
			.font(.system(size: 35))
			.accessibility(label: Text("minus 1 bpm"))

			Text("\(audioController.bpm)")
			.font(Font.custom("Futura", size: 65))
			.foregroundColor(Color("text"))
			.accessibility(label: Text("Current bpm: \(audioController.bpm)"))
			.frame(width: 150, height: 25)

			Button(action: { self.audioController.bpm += 1 }) { Image(systemName: "plus") }
			.buttonStyle(CustomButtonStyle(size: 45))
			.font(.system(size: 35))
			.accessibility(label: Text("plus 1 bpm"))
		}
    }
}
