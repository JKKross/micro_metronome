//
//  AppDelegate.swift
//  metronome
//
//  Created by Jan Kříž on 20/02/2020.
//  Copyright © 2020 Jan Kříž. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    #if targetEnvironment(macCatalyst)
    let controller = MasterController()
    #endif
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NSUbiquitousKeyValueStore.default.synchronize()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}

#if targetEnvironment(macCatalyst)
extension AppDelegate {
    
    // Mac Catalyst Menu Bar customization
    override func buildMenu(with builder: UIMenuBuilder) {
        // Check that the menu is Main menu as opposed to a context menu.
        guard builder.system == .main else { return }
        
        // Remove not needed menus
        builder.remove(menu: .format)
        builder.remove(menu: .edit)
        builder.remove(menu: .file)
        builder.remove(menu: .help)
        
        // Give user the ability to discover keyboard controls in a menu
        let keys = [
            UIKeyCommand(input: " ", modifierFlags: [], action: #selector(playPause)),
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(plusOneBPM)),
            UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(minusOneBPM)),
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [.command], action: #selector(plusTenBPM)),
            UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [.command], action: #selector(minusTenBPM)),
            UIKeyCommand(input: "", modifierFlags: [], action: #selector(doNothing)),
        ]
        
        keys[0].title = "Play/Pause"
        keys[1].title = "+1 bpm"
        keys[2].title = "-1 bpm"
        keys[3].title = "+10 bpm"
        keys[4].title = "-10 bpm"
        keys[5].title = "...or type your desired tempo & hit ⏎ to set it"
        
        let menuItems = UIMenu(title: "Controls", image: nil, identifier: UIMenu.Identifier("Controls"), options: .displayInline, children: keys)
        
        let menu = UIMenu(title: "Controls")
        
        builder.insertSibling(menu, beforeMenu: .view)
        builder.insertChild(menuItems, atEndOfMenu: menu.identifier)
    }
    
    @objc func playPause() {
        if controller.isPlaying {
            controller.stop()
        } else {
            controller.play()
        }
        
        controller.isPlaying.toggle()
    }
    
    @objc func plusOneBPM() {
        self.controller.setBPM(controller.bpm + 1)
    }
    
    @objc func minusOneBPM() {
        self.controller.setBPM(controller.bpm - 1)
    }
    
    @objc private func plusTenBPM() {
        // Why are we setting this twice here?
        // It's just a hack to trigger the .onReceive modifier on BPMSlider.
        // No idea why it's not working properly.
        self.controller.setBPM(controller.bpm + 10)
        self.controller.setBPM(controller.bpm)
    }
    
    @objc private func minusTenBPM() {
        // Why are we setting this twice here?
        // It's just a hack to trigger the .onReceive modifier on BPMSlider.
        // No idea why it's not working properly.
        self.controller.setBPM(controller.bpm - 10)
        self.controller.setBPM(controller.bpm)
    }
    
    @objc func doNothing() {}
}
#endif
