//
//  PlayPauseButton.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct PlayPauseButton: View {

	@EnvironmentObject var audioController: AudioController

	var body: some View {
		ZStack {
			RadialGradient(gradient: Gradient(colors: [.colorScheme, .white]), center: .center, startRadius: 20, endRadius: 40)
			.clipShape(Circle())
			.shadow(color: .colorScheme, radius: 15)
			.shadow(color: .colorScheme, radius: 10)
			.shadow(color: .colorScheme, radius: 05)

			Image(systemName: audioController.isPlaying ? "pause" : "play")
			.foregroundColor(.white)
			.font(Font.custom("System", size: 50))
			.shadow(color: .colorScheme, radius: 15)
			.shadow(color: .colorScheme, radius: 10)
			.shadow(color: .colorScheme, radius: 05)
		}
		.frame(width: 75, height: 75)
		.onTapGesture {
			if self.audioController.isPlaying {
				self.audioController.stop()
				self.audioController.prepareBuffer()
			} else {
				self.audioController.play()
			}

			self.audioController.isPlaying.toggle()
		}
	}
}
