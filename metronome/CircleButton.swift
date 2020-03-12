//
//  CircleButton.swift
//  metronome
//
//  Created by Jan Kříž on 12/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct CircleButton: View {

	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var settings: Settings

	private var colorStart: Color {
		switch self.settings.theme {
		case .standart :
			return Color(red: 0.2, green: 0.5, blue: 1)
		case .neomorphic:
			return Color.white
		case .neonGreen:
			return Color(red: 0.5, green: 1, blue: 0.5)
		}
	}

	private var colorEnd: Color {
		switch self.settings.theme {
		case .standart:
			return Color(red: 0.0, green: 0.2, blue: 1)
		case .neomorphic:
			return Color.gray
		case .neonGreen:
			return Color(red: 0.5, green: 1, blue: 0.5)
		}
	}

	private var shadowColor: Color {
		switch self.settings.theme {
			case .standart:
				return Color(red: 0, green: 0.6, blue: 1)
			case .neomorphic:
				return Color(red: 0.7, green: 0.8, blue: 1)
			case .neonGreen:
				return Color(red: 0.7, green: 0.8, blue: 1)
		}
	}

	var body: some View {
		LinearGradient(gradient: Gradient(colors: [colorStart, colorEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
		.clipShape(Circle())
		.shadow(color: shadowColor, radius: 10, x: 0, y: 0)
	}
}
