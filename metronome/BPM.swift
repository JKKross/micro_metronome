//
//  BPM.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct BPM: View {

	@EnvironmentObject var audioController: AudioController

	@State private var offset: CGFloat = 0.0
	@State private var previousOffset: CGFloat = 0.0
	@State private var sliderValue: CGFloat = 0.0

	var body: some View {
		GeometryReader { geo in
			ZStack {
				RadialGradient(gradient: Gradient(colors: [.colorScheme, .white]), center: .center, startRadius: 30, endRadius: 60)
				.clipShape(Circle())
				.shadow(color: .colorScheme, radius: 15)
				.shadow(color: .colorScheme, radius: 10)
				.shadow(color: .colorScheme, radius: 05)

				Text("\(self.audioController.bpm)")
				.font(Font.custom("System", size: 40))
				.bold()
				.foregroundColor(.white)
				.shadow(color: .colorScheme, radius: 15)
				.shadow(color: .colorScheme, radius: 10)
				.shadow(color: .colorScheme, radius: 05)

			}
			.frame(width: 100, height: 100)
			.offset(y: self.offset)
			.gesture(
				DragGesture()
				.onChanged { val in
					if self.audioController.isPlaying { self.audioController.stop() }
					self.offset = val.translation.height + self.previousOffset

					let containingViewHeight = geo.size.height - 100
					if self.offset > (containingViewHeight / 2) {
						self.offset = containingViewHeight / 2
					} else if self.offset < -(containingViewHeight / 2) {
						self.offset = -(containingViewHeight / 2)
					}
					let realValue = (containingViewHeight / 2 + self.offset)
					self.sliderValue = abs((realValue / containingViewHeight) - 1)
					self.audioController.bpm = Int(self.sliderValue * 280) + 20
				}
				.onEnded { _ in
					self.previousOffset = self.offset
					self.audioController.prepareBuffer()
					if self.audioController.isPlaying { self.audioController.play() }
				})
			.onAppear {
				let containingViewHeight = geo.size.height - 100
				self.sliderValue = CGFloat(self.audioController.bpm - 20) / 280
				self.offset = -(self.sliderValue * containingViewHeight - (containingViewHeight / 2))
				self.previousOffset = self.offset
			}
		}
	}
}
