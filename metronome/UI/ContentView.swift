//
//  ContentView.swift
//  metronome
//
//  Created by Jan Kříž on 20/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

fileprivate struct Background: View {

	private var colorStart = Color("background_start")
	private var colorEnd = Color("background_end")

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
			.gesture(
				DragGesture(minimumDistance: 0)
				.onEnded { val in
					let screenHeight = (UIScreen.main.bounds.height / 2)
						
					if val.location.y < (screenHeight - 50) && self.audioController.bpm < self.audioController.maxBPM {
						self.audioController.bpm += 1
					} else if val.location.y > (screenHeight + 50) && self.audioController.bpm > self.audioController.minBPM {
						self.audioController.bpm -= 1
					}
				})

			VStack {
				Text("\(audioController.bpm)")
				.font(Font.custom("Futura", size: 65))
				.padding(.top, 30)
				.foregroundColor(Color("text"))
				.accessibility(label: Text("\(audioController.bpm) bpm"))
				.frame(height: 55)

				BPMSlider()

				BottomControlsBar()
				.frame(height: 75)
				.padding(.bottom, 25)
				.padding(.top, 15)
				.padding(.horizontal, 35)
			}
		}
	}
}
