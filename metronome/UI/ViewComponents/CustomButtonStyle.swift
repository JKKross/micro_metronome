//
//  CustomButtonStyle.swift
//  metronome
//
//  Created by Jan Kříž on 21/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
	
	private let size: CGFloat
	
	init(size: CGFloat = 0) {
		self.size = size
	}
	
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.foregroundColor(configuration.isPressed ? Color("highlight_2") : Color("highlight"))
			.background(
				Circle()
					.foregroundColor(Color("controls"))
					.frame(width: size, height: size)
					.scaleEffect(configuration.isPressed ? 1.2 : 1)
					.shadow(color: Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)), radius: 3, x: -3, y: -3)
					.shadow(color: Color(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)), radius: 3, x: 3, y: 3)
		)
			.overlay(
				Circle()
					.foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: configuration.isPressed ? 0.2 : 0)))
					.frame(width: size, height: size)
					.scaleEffect(configuration.isPressed ? 1.2 : 1)
		)
			.padding(5)
	}
}
