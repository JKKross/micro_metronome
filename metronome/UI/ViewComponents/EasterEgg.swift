//
//  EasterEgg.swift
//  metronome
//
//  Created by Jan Kříž on 27/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI

struct EasterEgg: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Spacer()
                    .padding(.bottom, 2000)
                
                Text("Looking for something?")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("There's nothing to be found here")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Definitely no easter eggs or anything like that")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Trust me")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Really? Still trying?")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Go away")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("I said...")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("GO")
                    .foregroundColor(Color(red: 1, green: 0, blue: 0))
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.system(size: 50, weight: .bold))
                
                Text("AWAY!!!")
                    .foregroundColor(Color(red: 1, green: 0, blue: 0))
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.system(size: 60, weight: .bold))
            }
            
            Group {
                Text("You won't?")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("OK, you win...")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Here's your easter egg:")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Image("beethoven")
                    .padding(.bottom, 4000)
                
                Text("Really?! You're still here?!")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Jeez...")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Some people...")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("OK")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("Here it is for real")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
                
                Text("(Hope it was worth it)")
                    .foregroundColor(.white)
                    .frame(height: 2000, alignment: .topLeading)
                    .font(.headline)
            }
        }
    }
}

