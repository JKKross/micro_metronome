//
//  ContentView.swift
//  metronome
//
//  Created by Jan Kříž on 20/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var controller: MasterController

	var body: some View {
		ZStack {
			Color("background")
			.edgesIgnoringSafeArea(.all)

			VStack {
				TopControlsBar()
				.padding(.top, 15)
				.padding(.horizontal, 35)

				BPMSlider()

				BottomControlsBar()
				.frame(height: 75)
				.padding(.bottom, 25)
				.padding(.top, 20)
				.padding(.horizontal, 35)
			}
		}
	}
}
