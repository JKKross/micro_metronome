//
//  AboutTheApp.swift
//  metronome
//
//  Created by Jan Kříž on 27/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct AboutTheApp: View {
	
	private let appVersion  = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
	private let buildNumber = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String)
	
	private let privacyPolicyText = """
	I don't have access to any of your personal data and/or information. The only way I can gain access to said information is if you decide to send me an e-mail. In that case, I will never willingly share your e-mail address or any private information included in that e-mail with anyone.
	"""
	
	private let aboutTheAppText: String
	
	init() {
		aboutTheAppText  = """
		Micro Metronome is a minimalist metronome for iOS, iPadOS & MacOS.
		
		Pick your favorite sound, choose your tempo & start playing.
		That's it. No fancy features. Easy to use & lightweight.
		
		Happy practicing!
		
		
		Micro Metronome © 2020 Jan Kříž
		version \(appVersion ?? "APP_VERSION_NUMBER")
		build \(buildNumber ?? "BUILD_NUMBER")
		"""
	}
	
	var body: some View {
		Group {
			Text("About the app:")
				.font(.headline)
				.bold()
				.padding(.vertical, 15)
				.foregroundColor(.white)
			
			Text(aboutTheAppText)
				.foregroundColor(.white)
				.padding(.trailing, 20)
				.padding(.bottom, 15)
			
			Button(action: { UIApplication.shared.open(URL(string: "mailto:zawadski.jkk@gmail.com")!) }) { Text("Send feedback") }
				.foregroundColor(Color("highlight_2"))
				.hoverEffect(.highlight)
			
			Text("If your looking for a simple text editor for iOS & iPadOS, check out my other app:")
				.padding(.vertical, 15)
				.foregroundColor(.white)
			
			Button(action: { UIApplication.shared.open(URL(string: "https://itunes.apple.com/app/red-zebra/id1463017929?l=cs&ls=1&mt=8")!) }) { Text("Red Zebra") }
				.foregroundColor(Color("highlight_2"))
				.hoverEffect(.highlight)
				.padding(.bottom, 20)
			
			Text("Privacy Policy:")
				.font(.headline)
				.bold()
				.padding(.vertical, 15)
				.foregroundColor(.white)
			
			Text(privacyPolicyText)
				.foregroundColor(.white)
				.padding(.trailing, 20)
				.padding(.bottom, 15)
			
			Text("The app is also Open Source!")
				.font(.headline)
				.bold()
				.padding(.vertical, 15)
				.foregroundColor(.white)
			
			Button(action: { UIApplication.shared.open(URL(string: "https://github.com/JKKross/Micro_Metronome")!) }) { Text("Get the source code") }
				.foregroundColor(Color("highlight_2"))
				.hoverEffect(.highlight)
				.padding(.bottom, 20)
		}
	}
}
