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
			
			Text("Thanks to Seán W. McLoughlin - your videos got me through some hard times! PMA!")
			.foregroundColor(.white)
			
			Text("Thanks to Sean Allen for igniting my programming passion!")
			.foregroundColor(.white)
			
			Text("Thanks to James Thomson for showing me that easter eggs can be anywhere, not just in games! You rock, James!")
			.foregroundColor(.white)
			
			Button(action: { UIApplication.shared.open(URL(string: "https://apps.apple.com/us/developer/tla-systems-ltd/id284666225")!) }) { Text("(Go check out James' apps - some top notch easter eggs in those!)") }
			.foregroundColor(Color("highlight_2"))
			.hoverEffect(.highlight)
			
			Text("Thanks to all my friends who were kind enough to help me beta test this silly little app & for being here for me in general!")
			.foregroundColor(.white)
			
			Text("And last, but certainly not least: very special thanks to my wonderful girlfriend - for putting up with all my nonsense, horrible dad jokes & supporting me in everything I do! ❤️")
			.foregroundColor(.white)
		}
    }
}
