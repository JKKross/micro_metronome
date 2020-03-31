//
//  SceneDelegate.swift
//  metronome
//
//  Created by Jan Kříž on 20/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	// Definitely a H.A.C.K.
	// It's here (and in AppDelegate) so the user can tap the command in the "controls" menu & it works.
	// Maybe a bad idea.
	// Probably a bad idea.
	// If any issues come up, replace with:
	// let controller = AudioController()
	// and delete all the crap from AppDelegate.
	#if targetEnvironment(macCatalyst)
	let controller = (UIApplication.shared.delegate as! AppDelegate).controller
	#else
	let controller = MasterController()
	#endif


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Create the SwiftUI view that provides the window contents.
		let contentView = ContentView()

		// Use a UIHostingController as window root view controller.
		if let windowScene = scene as? UIWindowScene {
		    let window = UIWindow(windowScene: windowScene)
			window.rootViewController = KeyboardAwareUIHostingController(view: contentView.environmentObject(controller), controller: controller)
		    self.window = window
		    window.makeKeyAndVisible()
		}
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
		controller.saveStuff()
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
		controller.saveStuff()
	}

}
