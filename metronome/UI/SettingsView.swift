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

	private var isSelected: Bool { self.name.rawValue == self.currentlySelectedSound.rawValue }

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Button(action: self.action) { Text(self.name.rawValue) }
				.foregroundColor(Color("controls"))
				.frame(alignment: .leading)

				Spacer()

				Image(systemName: "checkmark.circle")
				.foregroundColor(isSelected ? .green : Color("background_end"))
			}
			.padding(.horizontal, 20)

			Divider()
			.padding(.leading, 20)
		}
	}
}

struct SettingsView: View {

	@Binding var selectedSound: Sounds
	@Binding var isOnScreen: Bool

    var body: some View {
		ZStack {
			Color("background_end")

			VStack {
				HStack {
					Text("Settings")
					.font(.largeTitle)
					.bold()
					.padding(.leading, 20)
					
					Spacer()
					
					Button(action: { self.isOnScreen = false }) { Image(systemName: "xmark") }
					.buttonStyle(CustomButtonStyle())
					.font(.largeTitle)
					.padding(.trailing, 20)
				}
				.padding(.vertical, 25)
				
				ScrollView {
					Group {
						Cell(action: { self.selectedSound = .rimshot }, name: .rimshot, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .bassDrum }, name: .bassDrum, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .clap }, name: .clap, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .cowbell }, name: .cowbell, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .hiHat }, name: .hiHat, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .hjonk }, name: .hjonk, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .jackSlap }, name: .jackSlap, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .laugh }, name: .laugh, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .uHuh }, name: .uHuh, currentlySelectedSound: selectedSound)
						Cell(action: { self.selectedSound = .elephant }, name: .elephant, currentlySelectedSound: selectedSound)
					}
				}
			}
			.frame(alignment: .topLeading)
				
				// About etc.
		}
	}

}
