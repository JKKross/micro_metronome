//
//  ContentView.swift
//  metronome
//
//  Created by Jan Kříž on 20/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	@State private var isPlaying = false
	@State private var bpm = 90

	var body: some View {
		ZStack {
// 			LinearGradient(gradient: Gradient(colors: [Color(red: , .backgroundEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
			Color.black
			.edgesIgnoringSafeArea(.all)

			VStack {
				BPM(bpm: self.$bpm)
				.padding(.top, 25)


				PlayPauseButton(isPlaying: $isPlaying)
				.frame(height: 75)
				.padding(.vertical, 25)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
