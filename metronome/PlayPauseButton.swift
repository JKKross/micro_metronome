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
			Circle()
			.foregroundColor(.clear)

			Image(systemName: audioController.isPlaying ? "pause" : "play")
 			.foregroundColor(Color("highlight"))
			.font(Font.custom("System", size: 50))
			.offset(x: audioController.isPlaying ? 0 : 3)
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
