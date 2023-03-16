//
//  ActiveLock.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/15/23.
//

import SwiftUI
import MapKit

struct ActiveLock: View {
    
    @Binding var showMap: Bool
    @Binding var lock: BikeLock
    @Binding var transactions: [Transaction]
    
    @State var isLocked: Bool = false
    
    @State var startTime = Date()
    
    func dateDiff() -> Double {
        let date = Date()
        let dateDiff = Calendar.current.dateComponents([.second], from: startTime, to: date)
        let seconds = dateDiff.second
        return Double(seconds ?? 1)
    }
    
    @State var difference: Double = 1
    
    @State var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    
    func amountOwned() -> Double {
        (0.00018 * difference + 0.01)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                    Text(startTime, style: .timer)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .shadow(color: .black.opacity(0.15), radius: 4.5)
                    .padding(.horizontal)
                Spacer()
                Button {
                    withAnimation {
                        isLocked.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: isLocked ? "lock.open.fill" : "lock.fill")
                        Text("\(isLocked ? "Unl" : "   L")ock")
                    } .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(Color("CrayolaBlue"))
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.15), radius: 3)
                        .padding(.horizontal)
                }
            }
            HStack {
                HStack {
                    Text("Amount Due:")
                    Text(amountOwned(), format: .currency(code: "USD"))
                }
                Spacer()
                Button {
                    withAnimation {
                        transactions.insert(Transaction(amount: amountOwned(), date: startTime, longitude: lock.coordinate.longitude, latitutde: lock.coordinate.latitude, cardNum: 1972), at: 0)
                        lock = BikeLock(id: "Not Selected", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
                    }
                } label: {
                    Image(systemName: "bicycle.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .shadow(color: .black.opacity(0.15), radius: 3)
                        .padding(.horizontal)
                }
            } .padding(.horizontal)
                .foregroundColor(Color("GlauciousBlue"))
        } .frame(width: screen().width * 0.95, height: 120)
            .background(.regularMaterial)
            .cornerRadius(20)
            .onReceive(timer, perform: { _ in
                difference = dateDiff()
            })
    }
}

struct ActiveLock_Previews: PreviewProvider {
    static var previews: some View {
        ActiveLock(showMap: .constant(false), lock: .constant(BikeLock(id: "Not Selected", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))), transactions: .constant([]))
    }
}
