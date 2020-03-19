//
//  BottomControlsBar.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
	
	let size: CGFloat
	
	init(size: CGFloat = 0) {
		self.size = size
	}

	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
 			.foregroundColor(Color("highlight"))
			.background(
				Circle()
					.foregroundColor(Color("controls"))
					.frame(width: size, height: size)
					.scaleEffect(configuration.isPressed ? 1.2 : 1)
					.shadow(color: Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)), radius: 3, x: -3, y: -3)
					.shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)), radius: 3, x: 3, y: 3)
			)
			.overlay(
				Circle()
					.foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: configuration.isPressed ? 0.2 : 0)))
					.frame(width: size, height: size)
					.scaleEffect(configuration.isPressed ? 1.2 : 1)
			)
	}
}

struct BottomControlsBar: View {

	@EnvironmentObject var audioController: AudioController
	@State private var isShowingSettingsView = false
	@State private var isShowingSetlistView = false

	var body: some View {

		HStack {
			Button(action: {
				self.isShowingSettingsView = true
			}) { Image(systemName: "gear") }
			.sheet(isPresented: $isShowingSettingsView) { SettingsView(selectedSound: self.$audioController.selectedSound, isOnScreen: self.$isShowingSettingsView) }
			.buttonStyle(CustomButtonStyle(size: 60))
			.font(.system(size: 35))
			.accessibility(label: Text("Settings"))

			Spacer()

			Button(action: {
				if self.audioController.isPlaying {
					self.audioController.stop()
					self.audioController.prepareBuffer()
				} else {
					self.audioController.play()
				}

				self.audioController.isPlaying.toggle()
			}) {
				Image(systemName: audioController.isPlaying ? "pause" : "play")
				.offset(x: audioController.isPlaying ? 0 : 3)
				}
			.buttonStyle(CustomButtonStyle(size: 80))
			.font(.system(size: 55))
			.accessibility(label: audioController.isPlaying ? Text("pause") : Text("play"))

			Spacer()

			Button(action: {
				self.isShowingSetlistView = true
			}) { Image(systemName: "music.note.list") }
			.buttonStyle(CustomButtonStyle(size: 60))
			.font(.system(size: 35))
			.accessibility(label: Text("Setlist"))
				.alert(isPresented: $isShowingSetlistView) {
					Alert(title: Text("Not implemented"), dismissButton: .default(Text("OK")))
			}
		}

	}
}
