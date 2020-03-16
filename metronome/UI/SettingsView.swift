//
//  SettingsView.swift
//  metronome
//
//  Created by Jan Kříž on 16/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
	
	@Binding var selectedSound: Sounds
	
    var body: some View {
		ZStack {
			Color("background_end")

			VStack {
				Button(action: { self.selectedSound = .rimshot }) { Text("Rimshot") }
				Button(action: { self.selectedSound = .bassDrum }) { Text("Bass Drum") }
				Button(action: { self.selectedSound = .clap }) { Text("Clap") }
				Button(action: { self.selectedSound = .cowbell }) { Text("Cowbell") }
				Button(action: { self.selectedSound = .hiHat }) { Text("Hi-hat") }
				Button(action: { self.selectedSound = .hjonk }) { Text("Hjonk") }
			}
		}
    }
}
