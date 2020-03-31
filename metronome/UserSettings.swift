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

fileprivate enum KVStoreKeys: String {
	case hours = "HOURS"
	case minutes = "MINUTES"
}

final class UserSettings {

	private let ud = UserDefaults.standard
	private let iCloudKVStore = NSUbiquitousKeyValueStore.default

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
		let localHours = ud.integer(forKey: UDKeys.hoursPracticed.rawValue)
		let localMinutes = ud.integer(forKey: UDKeys.minutesPracticed.rawValue)
		
		let iCloudHours = iCloudKVStore.longLong(forKey: KVStoreKeys.hours.rawValue)
		let iCloudMinutes = iCloudKVStore.longLong(forKey: KVStoreKeys.minutes.rawValue)
		
		if localHours < iCloudHours || localMinutes < iCloudMinutes {
			ud.set(Int(iCloudHours), forKey: UDKeys.hoursPracticed.rawValue)
			ud.set(Int(iCloudMinutes), forKey: UDKeys.minutesPracticed.rawValue)
			return (Int(iCloudHours), Int(iCloudMinutes))
		} else if localHours > iCloudHours || localMinutes > iCloudMinutes {
			iCloudKVStore.set(Int64(localHours), forKey: KVStoreKeys.hours.rawValue)
			iCloudKVStore.set(Int64(localMinutes), forKey: KVStoreKeys.minutes.rawValue)
			return (localHours, localMinutes)
		}
		
		return (localHours, localMinutes)
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
		
		iCloudKVStore.set(Int64(hours), forKey: KVStoreKeys.hours.rawValue)
		iCloudKVStore.set(Int64(minutes), forKey: KVStoreKeys.minutes.rawValue)
	}
	
}
