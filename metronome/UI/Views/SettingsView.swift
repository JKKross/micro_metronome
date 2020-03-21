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
				.foregroundColor(Color("highlight"))
				.frame(alignment: .leading)

				Spacer()

				Image(systemName: "checkmark.circle")
				.foregroundColor(isSelected ? .green : .clear)
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
[There will be some contact info & stuff here. Eventually...]

Privacy Policy:

I don't have access to any of your personal data and/or information. The only way I can gain access to said information is if you decide to send me an e-mail. In that case, I will never willingly share your e-mail address or any private information included in that e-mail with anyone.


Untitled Metronome © 2020 Jan Kříž
version \(appVersion ?? "APP_VERSION_NUMBER")
build \(buildNumber ?? "BUILD_NUMBER")
"""

struct SettingsView: View {

	@Binding var selectedSound: Sounds
	@Binding var isOnScreen: Bool

	@State private var isShowingAboutScreen = false

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
					.foregroundColor(.red)
					.font(.largeTitle)
					.padding(.trailing, 20)
					.accessibility(label: Text("Close settings"))
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
						.padding(.bottom, 2000)

						Group {
							Text("Looking for something?")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))

							Text("There's nothing to be found here")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))

							Text("Definitely no easter eggs or anything like that")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))

							Text("Trust me")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))

							Text("Really? Still trying?")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))

							Text("Go away")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))

							Text("I said...")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))

							Text("GO")
							.foregroundColor(Color(red: 1, green: 0, blue: 0))
							.padding(.bottom, 2000)
							.font(.system(size: 40))

							Text("AWAY!!!")
							.foregroundColor(Color(red: 1, green: 0, blue: 0))
							.padding(.bottom, 2000)
							.font(.system(size: 50, weight: .bold))

							Text("You won't?")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
						}
						
						Group {
							Text("OK, you win...")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
							
							Text("Here's your easter egg:")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
							
							Image("beethoven")
							.padding(.bottom, 4000)
							
							Text("Really?! You're still here?!")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
							
							Text("Jeez...")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
							
							Text("Some people...")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
							
							Text("OK")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
							
							Text("Here it is for real")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
							
							Text("(Hope it was worth it)")
							.foregroundColor(.white)
							.padding(.bottom, 2000)
							.font(.system(size: 30))
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
