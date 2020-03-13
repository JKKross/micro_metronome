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

	@State private var scale: CGFloat = 1.0

	var body: some View {
		ZStack {
			CircleButton()
			.scaleEffect(scale)
			.animation(.spring())

			Image(systemName: audioController.isPlaying ? "pause" : "play")
			.foregroundColor(.white)
			.font(Font.custom("System", size: 50))
			.offset(x: audioController.isPlaying ? 0 : 3)
		}
		.frame(width: 75, height: 75)
		.onTapGesture {
			DispatchQueue.main.asyncAfter(deadline: .now(), execute: { self.scale = 0.7 })
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: { self.scale = 1.2 })
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { self.scale = 1.0 })
			
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
