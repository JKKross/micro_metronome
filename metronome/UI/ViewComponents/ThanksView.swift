//
//  ThanksView.swift
//  metronome
//
//  Created by Jan Kříž on 29/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct ThanksView: View {
    var body: some View {
		Group {
			Text("Thank you's:")
			.font(.headline)
			.bold()
			.padding(.top, 30)
			.foregroundColor(.white)
			
			Text("Thanks to Seán McLoughlin (A.K.A. JackSepticEye) for making me LAUGH! Your videos got me through some hard times... PMA! 🍀")
			.foregroundColor(.white)
			
			Text("Thanks to Sean Allen for igniting my passion for programming. I literally wouldn't make this app if it wasn't for you! 💻")
			.foregroundColor(.white)
			
			Text("Thanks to James Thomson for inspiring me to start putting some easter eggs in the stuff I make. You rock, James! 🥚")
			.foregroundColor(.white)
			
			Button(action: { UIApplication.shared.open(URL(string: "https://apps.apple.com/us/developer/tla-systems-ltd/id284666225")!) }) { Text("(Go check out James' apps - some top notch easter eggs in those!)") }
			.foregroundColor(Color("highlight_2"))
			.hoverEffect(.highlight)
			
			Text("Special thanks to my brother Roman & all my friends who were kind enough to help me beta test this app - Oleg, Míla, Patrik, Lukáš, Matouš, Víťa & Martin. I'm lucky to have so many amazing musicians as friends! 🎸🥁")
			.foregroundColor(.white)
			
			Text("And last, but certainly not least: very special thanks to my wonderful girlfriend, Iris - for putting up with all my nonsense, horrible dad jokes, late nights in front of a laptop, supporting me in everything I do & generally being awesome! Love you with all my ❤️")
			.foregroundColor(.white)
		}
    }
}
