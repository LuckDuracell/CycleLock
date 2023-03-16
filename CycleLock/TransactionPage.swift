//
//  TransactionPage.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/15/23.
//

import SwiftUI
import MapKit

struct TransactionPage: View {
    
    @Binding var selectedTransaction: Transaction?
    
    @State var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 0,
                        longitude: 0),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.01,
                        longitudeDelta: 0.01)
                    )
    
    @State var annotations = [BikeLock(id: "", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))]
    
    var body: some View {
        ZStack {
            Color("AliceWhite")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Transaction")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .font(.largeTitle.bold())
                    .shadow(color: .black.opacity(0.15), radius: 3)
                    .padding(.vertical)
                Text(selectedTransaction?.date ?? Date(), style: .date)
                Text(selectedTransaction?.amount ?? -2, format: .currency(code: "USD"))
                Text("•••• •••• •••• \(selectedTransaction?.cardNum.description ?? "0000")")
                Map(coordinateRegion: $region, interactionModes: [], showsUserLocation: false, userTrackingMode: .none, annotationItems: annotations) { map in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: selectedTransaction?.latitutde ?? 0, longitude: selectedTransaction?.longitude ?? 0), content: {
                        Image(systemName: "lock.square.fill")
                            .font(.title2)
                            .foregroundStyle(.white, Color("GlauciousBlue"))
                    })
                }
                    .frame(width: screen().width * 0.9, height: 250)
                    .cornerRadius(20)
            } .font(.system(.headline, design: .rounded, weight: .bold))
                .frame(width: screen().width)
                .padding()
                .onAppear(perform: {
                    region.center.latitude = selectedTransaction?.latitutde ?? 0
                    region.center.longitude = selectedTransaction?.longitude ?? 0
                })
        }
    }
}

struct TransactionPage_Previews: PreviewProvider {
    static var previews: some View {
        TransactionPage(selectedTransaction: .constant(Transaction(amount: 15, date: Date.distantPast, longitude: 15.1985, latitutde: 14.157915, cardNum: 1422)))
    }
}
