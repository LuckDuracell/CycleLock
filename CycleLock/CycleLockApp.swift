//
//  CycleLockApp.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/10/23.
//

import SwiftUI

@main
struct CycleLockApp: App {
    
    let screen = UIScreen.main.bounds
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .preferredColorScheme(.light)
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            } .environmentObject(LaunchScreenStateManager())
        }
    }
}
