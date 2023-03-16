//
//  BouncyMapRotate.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/15/23.
//

import SwiftUI

struct BouncyMapRotate: View {
    
    @Binding var buttonScale: CGFloat
    @Binding var showMap: Bool
    
    var body: some View {
        Image(systemName: "light.panel.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(Color("CrayolaBlue"))
            .rotationEffect(Angle(degrees: showMap ? 90 : 0))
            .padding(.horizontal, showMap ? 30 : 15)
            .padding(.top, showMap ? 55 : 15)
            .scaleEffect(buttonScale)
            .offset(x: screen().width * 0.35, y: showMap ? screen().height * -0.6 : screen().height * -0.49)
            .onTapGesture {
                withAnimation(.spring(), {
                    showMap.toggle()
                    buttonScale = 0.6
                    
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                    withAnimation(.spring(), {
                            buttonScale = 1
                    })
                })
            }
            .shadow(color: .black.opacity(0.2), radius: 3)
    }
}

struct BouncyMapRotate_Previews: PreviewProvider {
    static var previews: some View {
        BouncyMapRotate(buttonScale: .constant(1), showMap: .constant(false))
    }
}
