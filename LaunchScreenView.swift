//
//  LaunchScreenView.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/15/23.
//

import Foundation
import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager // Mark 1

    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    @State private var startFadeoutAnimation = false // Mark 2
    
    @ViewBuilder
    private var image: some View {  // Mark 3
        Image("demoLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .rotationEffect(secondAnimation ? Angle(degrees: 360) : Angle(degrees: 0)) // Mark 4
            .scaleEffect(firstAnimation ? 0 : 1) // Mark 4
            .offset(y: firstAnimation ? 400 : 0) // Mark 4
    }
    
    @ViewBuilder
    private var backgroundColor: some View {  // Mark 3
        Color("AliceWhite").edgesIgnoringSafeArea(.all)
    }
    
    private let animationTimer = Timer // Mark 5
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor  // Mark 3
            image  // Mark 3
        }.onReceive(animationTimer) { timerValue in
            updateAnimation()  // Mark 5
        }.opacity(startFadeoutAnimation ? 0 : 1)
    }
    
    private func updateAnimation() { // Mark 5
        switch launchScreenState.state {
        case .firstStep:
            withAnimation(.easeInOut(duration: 0.9)) {
                firstAnimation.toggle()
            }
        case .secondStep:
            if secondAnimation == false {
                withAnimation(.easeIn(duration: 0.6)) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                }
            }
        case .finished:
            // use this case to finish any work needed
            break
        }
    }
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
