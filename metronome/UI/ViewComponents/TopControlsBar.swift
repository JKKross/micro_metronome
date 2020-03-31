//
//  TopControlsBar.swift
//  metronome
//
//  Created by Jan Kříž on 19/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct TopControlsBar: View {

	@EnvironmentObject var controller: MasterController

	var body: some View {
		HStack {
			Button(action: {
				self.controller.setBPM(self.controller.bpm - 1)
			}) { Image(systemName: "minus") }
			.buttonStyle(CustomButtonStyle(size: 55))
			.font(.system(size: 40))
			.accessibility(label: Text("minus 1 bpm"))
			.padding(12)
			.hoverEffect(.highlight)

			Text("\(controller.bpm)")
			.font(Font.custom("Futura", size: 65))
			.foregroundColor(Color("text"))
			.accessibility(label: Text("Current bpm: \(controller.bpm)"))
			.frame(width: 125, height: 1)

			Button(action: {
				self.controller.setBPM(self.controller.bpm + 1)
			}) { Image(systemName: "plus") }
			.buttonStyle(CustomButtonStyle(size: 55))
			.font(.system(size: 40))
			.accessibility(label: Text("plus 1 bpm"))
			.padding(12)
			.hoverEffect(.highlight)
		}
	}
}
