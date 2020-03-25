//
//  UserSettings.swift
//  metronome
//
//  Created by Jan Kříž on 22/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import Foundation

fileprivate enum UDKeys: String {
	case bpm   = "BPM"
	case sound = "SOUND"
}

final class UserSettings {

	private let ud = UserDefaults.standard

	public func getBPM() -> Int {
		let bpm = ud.integer(forKey: UDKeys.bpm.rawValue)

		if bpm == 0 {
			ud.set(100, forKey: UDKeys.bpm.rawValue)
			return 100
		} else {
			return bpm
		}
	}

	public func getPreferredSound() -> Sounds {
		if let sound = ud.string(forKey: UDKeys.sound.rawValue) {
			return Sounds(rawValue: sound)!
		} else {
			ud.set(Sounds.mechanicalMetronome.rawValue as Any, forKey: UDKeys.sound.rawValue)
			return .mechanicalMetronome
		}
	}

	public func save(bpm: Int) {
		ud.set(bpm, forKey: UDKeys.bpm.rawValue)
	}

	public func save(preferredSound: Sounds) {
		ud.set(preferredSound.rawValue as Any, forKey: UDKeys.sound.rawValue)
	}
	
}
