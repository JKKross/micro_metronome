//
//  BottomControlsBar.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

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
				.foregroundColor(audioController.isPlaying ? Color("highlight_2") : Color("highlight"))
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
