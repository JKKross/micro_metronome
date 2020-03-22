//
//  BPMSlider.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI


struct BPMSlider: View {

	@EnvironmentObject var audioController: AudioController

	@State private var offset: CGFloat = 0.0
	@State private var previousOffset: CGFloat = 0.0
	@State private var sliderValue: CGFloat = 0.0
	// This is hacky AF...
	@State private var shouldRespondToPublisher = true

	var body: some View {
		GeometryReader { geo in
			ZStack {
				RoundedRectangle(cornerRadius: 5)
				.frame(width: 10)
				.foregroundColor(Color("secondary_controls"))

				RoundedRectangle(cornerRadius: 5)
				.frame(width: 120, height: 35)
				.foregroundColor(.black)
				.shadow(color: Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)), radius: 3, x: -3, y: -3)
				.shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)), radius: 3, x: 3, y: 3)
				.overlay(
					RoundedRectangle(cornerRadius: 3)
					.frame(width: 103, height: 10)
					.foregroundColor(Color("highlight_2"))
				)
				.offset(y: self.offset)
			}
			.gesture(
				DragGesture(minimumDistance: 5)
				.onChanged { val in
					self.shouldRespondToPublisher = false
					
					if self.audioController.isPlaying { self.audioController.stop() }
					self.offset = val.translation.height + self.previousOffset

					let containingViewHeight = geo.size.height
					if self.offset > (containingViewHeight / 2) {
						self.offset = containingViewHeight / 2
					} else if self.offset < -(containingViewHeight / 2) {
						self.offset = -(containingViewHeight / 2)
					}
					let realValue = (containingViewHeight / 2 + self.offset)
					self.sliderValue = abs((realValue / containingViewHeight) - 1)
					self.audioController.bpm = Int(self.sliderValue * CGFloat(self.audioController.maxBPM - self.audioController.minBPM)) + self.audioController.minBPM
				}
				.onEnded { _ in
					self.shouldRespondToPublisher = true
					self.previousOffset = self.offset
					self.audioController.prepareBuffer()
					if self.audioController.isPlaying { self.audioController.play() }
				})
			.onAppear {
				let containingViewHeight = geo.size.height
				self.sliderValue = CGFloat(self.audioController.bpm - self.audioController.minBPM) / CGFloat(self.audioController.maxBPM - self.audioController.minBPM)
				self.offset = -(self.sliderValue * containingViewHeight - (containingViewHeight / 2))
				self.previousOffset = self.offset
			}
			.onReceive(self.audioController.$bpm) { _ in
				guard self.shouldRespondToPublisher else { return }
				
				if self.audioController.isPlaying { self.audioController.stop() }
				
				let containingViewHeight = geo.size.height
				self.sliderValue = CGFloat(self.audioController.bpm - self.audioController.minBPM) / CGFloat(self.audioController.maxBPM - self.audioController.minBPM)
				self.offset = -(self.sliderValue * containingViewHeight - (containingViewHeight / 2))
				self.previousOffset = self.offset
				
				self.audioController.prepareBuffer()
				if self.audioController.isPlaying { self.audioController.play() }
			}
		
		}
	}
}
