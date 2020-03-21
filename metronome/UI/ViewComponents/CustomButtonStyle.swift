//
//  CustomButtonStyle.swift
//  metronome
//
//  Created by Jan Kříž on 21/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
	
	let size: CGFloat
	
	init(size: CGFloat = 0) {
		self.size = size
	}

	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
 			.foregroundColor(Color("highlight"))
			.background(
				Circle()
					.foregroundColor(Color("controls"))
					.frame(width: size, height: size)
					.scaleEffect(configuration.isPressed ? 1.2 : 1)
					.shadow(color: Color(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)), radius: 3, x: -3, y: -3)
					.shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)), radius: 3, x: 3, y: 3)
			)
			.overlay(
				Circle()
					.foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: configuration.isPressed ? 0.2 : 0)))
					.frame(width: size, height: size)
					.scaleEffect(configuration.isPressed ? 1.2 : 1)
			)
	}
}
