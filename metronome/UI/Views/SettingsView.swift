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

fileprivate let appVersion  = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
fileprivate let buildNumber = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String)

fileprivate let aboutTheAppText = """
Micro Metronome is a minimalist metronome.

Choose one of the few sounds, pick your tempo & start playing. That's it. No fancy features.
In exchange, it is easy to use & lightweight.

Happy practicing!


Micro Metronome © 2020 Jan Kříž
version \(appVersion ?? "APP_VERSION_NUMBER")
build \(buildNumber ?? "BUILD_NUMBER")


Privacy Policy:

I don't have access to any of your personal data and/or information. The only way I can gain access to said information is if you decide to send me an e-mail. In that case, I will never willingly share your e-mail address or any private information included in that e-mail with anyone.
"""

struct SettingsView: View {

	@Binding var selectedSound: Sounds
	@Binding var isOnScreen: Bool

    var body: some View {
		ZStack {
			Color("settings_background")

			VStack {
				HStack {
					Text("Settings")
					.font(.largeTitle)
					.bold()
					.padding(.leading, 20)
					.foregroundColor(.white)

					Spacer()

					Button(action: { self.isOnScreen = false }) { Image(systemName: "xmark") }
					.foregroundColor(Color("highlight_2"))
					.font(.largeTitle)
					.padding(20)
					.accessibility(label: Text("Close settings"))
					.hoverEffect(.highlight)
				}
				.padding(.vertical, 25)

				ScrollView(.vertical, showsIndicators: true) {
					VStack(alignment: .leading) {
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

						Text("About the app:")
						.font(.headline)
						.bold()
						.padding(.vertical, 15)
						.foregroundColor(.white)

						Text(aboutTheAppText)
						.foregroundColor(.white)
						.padding(.trailing, 20)
						.padding(.bottom, 25)

						Button(action: { UIApplication.shared.open(URL(string: "mailto:zawadski.jkk@gmail.com")!) }) { Text("Send feedback") }
						.foregroundColor(Color("highlight_2"))
						.hoverEffect(.highlight)

						Spacer()
						.padding(.bottom, 2000)


						Group {
							Text("Looking for something?")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("There's nothing to be found here")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Definitely no easter eggs or anything like that")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Trust me")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Really? Still trying?")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Go away")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("I said...")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("GO")
							.foregroundColor(Color(red: 1, green: 0, blue: 0))
							.frame(height: 2000, alignment: .topLeading)
							.font(.system(size: 50, weight: .bold))

							Text("AWAY!!!")
							.foregroundColor(Color(red: 1, green: 0, blue: 0))
							.frame(height: 2000, alignment: .topLeading)
							.font(.system(size: 60, weight: .bold))

							Text("You won't?")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)
						}

						Group {
							Text("OK, you win...")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Here's your easter egg:")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Image("beethoven")
							.padding(.bottom, 4000)

							Text("Really?! You're still here?!")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Jeez...")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Some people...")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("OK")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("Here it is for real")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)

							Text("(Hope it was worth it)")
							.foregroundColor(.white)
							.frame(height: 2000, alignment: .topLeading)
							.font(.headline)
						}

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
