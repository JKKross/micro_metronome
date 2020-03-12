//
//  Settings.swift
//  metronome
//
//  Created by Jan Kříž on 12/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

enum Theme {
	case standart
	case neomorphic
	case neonGreen
	/*
	case neonBlue
	case neonRed
	...
	*/
}


final class Settings: ObservableObject {

	@Published public var theme: Theme = .standart

}
