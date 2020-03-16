//
//  SettingsView.swift
//  metronome
//
//  Created by Jan Kříž on 16/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

fileprivate struct ListButton: View {

	@Binding var selectedSound: Sounds
	public let name: String

	var body: some View {
		VStack(alignment: .leading) {
			Divider()
		}
	}
}

fileprivate struct Cell: View {

	public var action: () -> ()
	public var name: Sounds
	public var currentlySelectedSound: Sounds

	private var isSelected: String {
		if self.name.rawValue == self.currentlySelectedSound.rawValue {
			return "checkmark.circle"
		} else {
			return ""
		}
	}

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Button(action: self.action) { Text(self.name.rawValue) }
				.font(Font.custom("System Bold", size: 25))
				.foregroundColor(Color("controls"))
				.frame(alignment: .leading)

				Spacer()

				Image(systemName: isSelected)
				.foregroundColor(.green)
			}
			.padding(.horizontal, 20)

			Divider()
			.padding(.leading, 20)
		}
	}
}

struct SettingsView: View {

	@Binding var selectedSound: Sounds

    var body: some View {
		ZStack {
			Color("background_end")

			VStack {
				HStack {
					// close button

					Text("Settings")
					.font(.largeTitle)
					.bold()
				}
				.padding(.vertical, 25)

				Group {
					Cell(action: { self.selectedSound = .rimshot }, name: .rimshot, currentlySelectedSound: selectedSound)
					Cell(action: { self.selectedSound = .bassDrum }, name: .bassDrum, currentlySelectedSound: selectedSound)
					Cell(action: { self.selectedSound = .clap }, name: .clap, currentlySelectedSound: selectedSound)
					Cell(action: { self.selectedSound = .cowbell }, name: .cowbell, currentlySelectedSound: selectedSound)
					Cell(action: { self.selectedSound = .hiHat }, name: .hiHat, currentlySelectedSound: selectedSound)
					Cell(action: { self.selectedSound = .hjonk }, name: .hjonk, currentlySelectedSound: selectedSound)
				}

				Spacer()
			}
			.frame(alignment: .topLeading)

				// About etc.
		}
	}

}
