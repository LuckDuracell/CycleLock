//
//  ContentView.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    var body: some View {
            MainPage()
                .task {
                    self.launchScreenState.dismiss()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenStateManager())
    }
}

struct screen {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
}


func CustomRoundedRect(width: CGFloat, height: CGFloat) -> any Shape {
    return RoundedRectangle(cornerRadius: 20).frame(width: width, height: height) as! (any Shape)
}
