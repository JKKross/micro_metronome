//
//  ContentView.swift
//  metronome
//
//  Created by Jan Kříž on 20/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

fileprivate struct Background: View {

	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var settings: Settings

	private var colorStart: Color {
		switch self.settings.theme {
		case .standart:
			if colorScheme == .dark {
				return Color.black
			} else {
				return Color.white
			}
		case .neomorphic:
			return Color.white
		case .neonGreen:
			return Color.black
		}
	}
	private var colorEnd: Color {
		switch self.settings.theme {
		case .standart:
			if colorScheme == .dark {
				return Color.black
			} else {
				return Color.white
			}
		case .neomorphic:
			return Color.white
		case .neonGreen:
			return Color.black
		}
	}

	var body: some View {
		LinearGradient(gradient: Gradient(colors: [colorStart, colorEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
	}
}

struct ContentView: View {

	@EnvironmentObject var audioController: AudioController

	var body: some View {
		ZStack {
			Background()
			.edgesIgnoringSafeArea(.all)

			VStack {
				BPM()
				.padding(.top, 25)

				PlayPauseButton()
				.frame(height: 75)
				.padding(.vertical, 25)
			}
		}
		.onAppear {
			self.audioController.prepareBuffer()
			self.audioController.setUpAudioSession()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
