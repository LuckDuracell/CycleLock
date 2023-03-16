//
//  LargeTitle.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/10/23.
//

import SwiftUI

struct LargeTitle: View {
    
    let title: String
    @Binding var scanLock: Bool
    
    @State var animateButton = false
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 25)
                .padding(.top, 20)
                .shadow(color: .black.opacity(0.15), radius: 4.5)
            Spacer()
            Button {
                scanLock.toggle()
                withAnimation(.spring()) {
                    animateButton = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    withAnimation(.spring()) {
                        animateButton = false
                    }
                })
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color("CrayolaBlue"))
                        .frame(width: 40, height: 40)
                    Image(systemName: "qrcode")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                } .scaleEffect(animateButton ? 0.7 : 1)
                    .offset(y: animateButton ? 7 : 1)
            }
            .frame(width: 40, height: 40)
            .padding(.horizontal, 25)
            .padding(.top, 25)
        }
    }
}

struct LargeTitle_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
