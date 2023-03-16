//
//  StaticDotBackground.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/13/23.
//

import SwiftUI

struct StaticDotBackground: View {
    
    let orbCount: (width: Int, height: Int) = ((Int(UIScreen.main.nativeBounds.width) / 22), Int(UIScreen.main.nativeBounds.height) / 22)
    
    var body: some View {
        ZStack {
            Color("AliceWhite")
                .edgesIgnoringSafeArea(.all)
                .overlay(content: {
                    ZStack {
                        Rectangle()
                            .edgesIgnoringSafeArea(.all)
                            .foregroundColor(.white.opacity(0.45))
                        ForEach(0...orbCount.height, id: \.self) { row in
                            ForEach(0...orbCount.width, id: \.self) { column in
                                Circle()
                                    .foregroundColor(Color("NeonBlue").opacity(0.05))
                                    .frame(width: 3, height: 10)
                                    .offset(x: CGFloat(column * 9) - (screen().width / 1.5), y: CGFloat(row * 9) - screen().height / 1.8)
                            }
                        }
                    }
                })
        }
    }
}

struct StaticDotBackground_Previews: PreviewProvider {
    static var previews: some View {
        StaticDotBackground()
    }
}
