////
////  DotGridBackground.swift
////  CycleLock
////
////  Created by Luke Drushell on 3/10/23.
////
//
//import SwiftUI
//
//struct DotGridBackground: View {
//
//    @State private var timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
//
//    @State var scale: CGFloat = 1
//    let orbCount: (width: Int, height: Int) = ((Int(UIScreen.main.nativeBounds.width) / 28), Int(UIScreen.main.nativeBounds.height) / 30)
//
//    func updateScale() {
//        scale = 1.1
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
//            scale = 1
//        })
//    }
//
//    var body: some View {
//        ZStack {
//            LinearGradient(colors: [.green, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//                .overlay(content: {
//                    ZStack {
//                        Rectangle()
//                            .edgesIgnoringSafeArea(.all)
//                            .foregroundColor(.white.opacity(0.25))
//                        ForEach(0...orbCount.height, id: \.self) { row in
//                            ForEach(0...orbCount.width, id: \.self) { column in
//                                Circle()
//                                    .foregroundColor(.white.opacity(0.15))
//                                    .frame(width: 4, height: 4)
//                                    .offset(x: CGFloat(column * 11) - (screen().width / 1.5), y: CGFloat(row * 11) - screen().height / 1.8)
//                                    .scaleEffect(scale)
//                                    .animation(.easeInOut(duration: 1.2).delay(Double(row + column) * 0.04), value: scale)
//                            }
//                        }
//                    }
//                })
//                .onReceive(timer, perform: { _ in
//                    updateScale()
//                })
//                .onAppear(perform: {
//                    print(orbCount.width * orbCount.height)
//                })
//        }
//    }
//}
//
//struct DotGridBackground_Previews: PreviewProvider {
//    static var previews: some View {
//        DotGridBackground()
//    }
//}
