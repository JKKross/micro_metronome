//
//  SettingsView.swift
//  metronome
//
//  Created by Jan Kříž on 16/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

fileprivate struct Cell: View {

	public var action: () -> ()
	public var name: Sounds
	public var currentlySelectedSound: Sounds

	private var isSelected: Bool { self.name.rawValue == self.currentlySelectedSound.rawValue }

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Button(action: self.action) { Text(self.name.rawValue) }
				.foregroundColor(isSelected ? Color("highlight_2") : Color("highlight"))
				.frame(alignment: .leading)
				.hoverEffect(.highlight)

				Spacer()

				Image(systemName: "checkmark.circle")
				.foregroundColor(isSelected ? .white : .clear)
				.accessibility(label: isSelected ? Text("Selected") : Text("Not selected"))
				.padding(.trailing, 20)
			}

			Divider()
		}
	}
}



struct SettingsView: View {

	@Binding var selectedSound: Sounds
	@Binding var isOnScreen: Bool
	@Binding var hoursPracticed: Int
	@Binding var minutesPracticed: Int

    var body: some View {
		ZStack {
			Color("settings_background")
			.edgesIgnoringSafeArea(.all)

			VStack {
				HStack {
					Text("Settings")
					.font(.largeTitle)
					.bold()
					.padding(20)
					.foregroundColor(.white)

					Spacer()

					Button(action: { self.isOnScreen = false }) { Image(systemName: "xmark") }
					.foregroundColor(Color("highlight_2"))
					.font(.largeTitle)
					.padding(20)
					.accessibility(label: Text("Close settings"))
					.hoverEffect(.highlight)
				}

				ScrollView(.vertical, showsIndicators: true) {
					VStack(alignment: .leading) {
						Text("You've practiced \(hoursPracticed) hours & \(minutesPracticed) minutes so far with Micro Metronome!")
						.font(.headline)
						.bold()
						.foregroundColor(.white)
						.padding(.bottom, 30)
						
						Text("Sounds:")
						.font(.headline)
						.bold()
						.padding(.bottom, 10)
						.foregroundColor(.white)

						Group {
							Cell(action: { self.selectedSound = .mechanicalMetronome }, name: .mechanicalMetronome, currentlySelectedSound: selectedSound)
							Cell(action: { self.selectedSound = .rimshot }, name: .rimshot, currentlySelectedSound: selectedSound)
							Cell(action: { self.selectedSound = .bassDrum }, name: .bassDrum, currentlySelectedSound: selectedSound)
							Cell(action: { self.selectedSound = .clap }, name: .clap, currentlySelectedSound: selectedSound)
							Cell(action: { self.selectedSound = .cowbell }, name: .cowbell, currentlySelectedSound: selectedSound)
							Cell(action: { self.selectedSound = .hiHat }, name: .hiHat, currentlySelectedSound: selectedSound)
						}

						AboutTheApp()

						EasterEgg()

						Group {
							Cell(action: { self.selectedSound = .hjonk }, name: .hjonk, currentlySelectedSound: selectedSound)
							Cell(action: { self.selectedSound = .jackSlap }, name: .jackSlap, currentlySelectedSound: selectedSound)
							Cell(action: { self.selectedSound = .laugh }, name: .laugh, currentlySelectedSound: selectedSound)
						}
					}
				}
				.padding(.leading, 20)
			}
			.frame(alignment: .topLeading)
		}
	}

}
