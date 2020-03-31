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
	case hoursPracticed = "HOURS_PRACTICED"
	case minutesPracticed = "MINUTES_PRACTICED"
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
			return Sounds(rawValue: sound) ?? .mechanicalMetronome
		} else {
			ud.set(Sounds.mechanicalMetronome.rawValue as Any, forKey: UDKeys.sound.rawValue)
			return .mechanicalMetronome
		}
	}
	
	public func getHoursAndMinutes() -> (Int, Int) {
		let hours = ud.integer(forKey: UDKeys.hoursPracticed.rawValue)
		let minutes = ud.integer(forKey: UDKeys.minutesPracticed.rawValue)
		
		return (hours, minutes)
	}

	public func save(bpm: Int) {
		ud.set(bpm, forKey: UDKeys.bpm.rawValue)
	}

	public func save(preferredSound: Sounds) {
		ud.set(preferredSound.rawValue as Any, forKey: UDKeys.sound.rawValue)
	}
	
	public func save(hours: Int, minutes: Int) {
		ud.set(hours, forKey: UDKeys.hoursPracticed.rawValue)
		ud.set(minutes, forKey: UDKeys.minutesPracticed.rawValue)
	}
	
}
