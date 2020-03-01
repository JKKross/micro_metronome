//
//  BPM.swift
//  metronome
//
//  Created by Jan Kříž on 22/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct BPM: View {

	@Binding public var bpm: Int

	@State private var offset: CGFloat = 0.0
	@State private var previousOffset: CGFloat = 0.0

	var body: some View {
		ZStack {
		Rectangle()
		.foregroundColor(.yellow) // TODO: Just for visual reference, delete later

		GeometryReader { geo in
		ZStack {
			RadialGradient(gradient: Gradient(colors: [.colorScheme, .white]), center: .center, startRadius: 30, endRadius: 60)
			.clipShape(Circle())
			.shadow(color: .colorScheme, radius: 15)
			.shadow(color: .colorScheme, radius: 10)
			.shadow(color: .colorScheme, radius: 05)

			Text("\(self.bpm)")
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
				self.offset = val.translation.height + self.previousOffset

				let containingViewHeight = geo.size.height - 100
				if self.offset > (containingViewHeight / 2) {
					self.offset = containingViewHeight / 2
				} else if self.offset < -(containingViewHeight / 2) {
					self.offset = -(containingViewHeight / 2)
				}
				// 300 is the max bpm
				let realValue = (self.offset / (geo.size.height - 100) - 0.5) * 300 // TODO: Refactor
				// 20 is the min bpm
				self.bpm = Int(abs(realValue)) + 20 // TODO: Refactor
			}
			.onEnded { _ in
				self.previousOffset = self.offset
			})
		}
		}
	}
}
