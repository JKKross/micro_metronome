//
//  SettingsView.swift
//  metronome
//
//  Created by Jan Kříž on 16/03/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import SwiftUI
import MetronomeKit

fileprivate struct Cell: View {
	
	public var action: () -> ()
	public var name: Sounds
	public var currentlySelectedSound: Sounds
	
	private var isSelected: Bool { self.name.rawValue == self.currentlySelectedSound.rawValue }
	
	var body: some View {
		VStack(alignment: .leading) {
			ZStack {
				// This is here just so the whole row is tapable
				Color("settings_background")
				
				HStack {
					Text(self.name.rawValue)
						.foregroundColor(isSelected ? Color("highlight_2") : Color("highlight"))
						.frame(alignment: .leading)
					
					Spacer()
					
					Image(systemName: "checkmark.circle")
						.foregroundColor(isSelected ? .white : .clear)
						.accessibility(label: isSelected ? Text("Selected") : Text("Not selected"))
						.padding(.trailing, 15)
				}
			}
			.hoverEffect(.highlight)
			.onTapGesture { self.action() }
			
			Divider()
		}
	}
}



struct SettingsView: View {
	
	@EnvironmentObject var controller: MasterController
	
	@Binding var isOnScreen: Bool
	
	@State private var shouldShowEraseAlert               = false
	@State private var shouldShowResetOnAllDevicesMessage = false
	
	var body: some View {
		ZStack {
			Color("settings_background")
				.edgesIgnoringSafeArea(.all)
			
			VStack {
				HStack {
					Text("Settings")
						.font(.largeTitle)
						.bold()
						.padding(20)
						.foregroundColor(.white)
					
					Spacer()
					
					Button(action: { self.isOnScreen = false }) { Image(systemName: "xmark") }
						.foregroundColor(Color("highlight_2"))
						.font(.largeTitle)
						.padding(20)
						.accessibility(label: Text("Close settings"))
						.hoverEffect(.highlight)
				}
				
				ScrollView(.vertical, showsIndicators: true) {
					VStack(alignment: .leading) {
						Text("You've practiced \(controller.totalHoursPracticedSoFar) \(controller.totalHoursPracticedSoFar == 1 ? "hour" : "hours") & \(controller.totalMinutesPracticedSoFar) \(controller.totalMinutesPracticedSoFar == 1 ? "minute" : "minutes") so far with Micro Metronome!")
							.font(.headline)
							.bold()
							.foregroundColor(.white)
							.padding(.bottom, 30)
						
						Text("Sounds:")
							.font(.headline)
							.bold()
							.padding(.bottom, 10)
							.foregroundColor(.white)
						
						Group {
							Cell(action: { self.controller.selectedSound = .mechanicalMetronomeLow }, name: .mechanicalMetronomeLow, currentlySelectedSound: controller.selectedSound)
							Cell(action: { self.controller.selectedSound = .mechanicalMetronomeHigh }, name: .mechanicalMetronomeHigh, currentlySelectedSound: controller.selectedSound)
							Cell(action: { self.controller.selectedSound = .rimshot }, name: .rimshot, currentlySelectedSound: controller.selectedSound)
							Cell(action: { self.controller.selectedSound = .bassDrum }, name: .bassDrum, currentlySelectedSound: controller.selectedSound)
							Cell(action: { self.controller.selectedSound = .cowbell }, name: .cowbell, currentlySelectedSound: controller.selectedSound)
							Cell(action: { self.controller.selectedSound = .hiHat }, name: .hiHat, currentlySelectedSound: controller.selectedSound)
						}
						
						AboutTheApp()
						
						Button(action: { self.shouldShowEraseAlert = true }) { Text("Reset total hours & minutes practiced so far") }
							.foregroundColor(Color("highlight_2"))
							.hoverEffect(.highlight)
							.padding(.top, 20)
							.alert(isPresented: $shouldShowEraseAlert) {
								
								if self.shouldShowResetOnAllDevicesMessage {
									return Alert(title: Text("Please note that if you have Micro Metronome installed on some of your other devices, you need to reset the hours & minutes practiced so far on those as well"),
												 dismissButton: .default(Text("OK")) { self.shouldShowResetOnAllDevicesMessage = false })
								} else {
									return Alert(title: Text("Set total hours & minutes practiced to 0?"),
												 message: Text("THIS ACTION RESULTS IN PERMANENT LOSS OF YOUR PRACTICE TIME DATA!"),
												 primaryButton: .destructive(Text("Delete it")) {
													self.controller.totalHoursPracticedSoFar = 0
													self.controller.totalMinutesPracticedSoFar = 0
													self.controller.saveStuff()
													NSUbiquitousKeyValueStore.default.synchronize()
													self.shouldShowResetOnAllDevicesMessage = true
													
													DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.shouldShowEraseAlert = true }
										},
												 secondaryButton: .default(Text("Keep it")))
								}
						}
						
						EasterEgg()
						
						Group {
							Cell(action: { self.controller.selectedSound = .jackSlap }, name: .jackSlap, currentlySelectedSound: controller.selectedSound)
							Cell(action: { self.controller.selectedSound = .laugh }, name: .laugh, currentlySelectedSound: controller.selectedSound)
						}
						
						ThanksView()
							.padding(.bottom, 20)
					}
				}
				.padding(.leading, 20)
				.padding(.trailing, 5)
			}
			.frame(alignment: .topLeading)
		}
	}
	
}
