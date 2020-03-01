//
//  ContentView.swift
//  metronome
//
//  Created by Jan Kříž on 20/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	var body: some View {
		ZStack {
// 			LinearGradient(gradient: Gradient(colors: [Color(red: , .backgroundEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
			Color.black
			.edgesIgnoringSafeArea(.all)

			VStack {
				BPM()
				.padding(.top, 25)

				PlayPauseButton()
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
