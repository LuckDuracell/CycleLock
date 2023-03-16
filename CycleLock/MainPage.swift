//
//  MainPage.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/15/23.
//

import SwiftUI
import CodeScanner
import MapKit

struct MainPage: View {
    @State private var showMap: Bool = false
    @State private var buttonScale: CGFloat = 1
    
    @State private var scanLock: Bool = false
    
    @State var selectedLock = BikeLock(id: "Not Selected", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    
    @State var selectedTransaction: Transaction?
    @State var showTransactionSheet = false
    
    @State var transactions: [Transaction] = [Transaction(amount: 0.43, date: Date(), longitude: -121.7476, latitutde: 38.5489, cardNum: 1972), Transaction(amount: 0.55, date: Date(timeIntervalSinceNow: -100000), longitude: -121.7476, latitutde: 38.5489, cardNum: 1972), Transaction(amount: 0.09, date: Date(timeIntervalSinceNow: -200000), longitude: -121.7476, latitutde: 38.5489, cardNum: 1972), Transaction(amount: 0.93, date: Date(timeIntervalSinceNow: -300000), longitude: -121.7476, latitutde: 38.5489, cardNum: 1972), Transaction(amount: 0.24, date: Date(timeIntervalSinceNow: -400000), longitude: -121.7476, latitutde: 38.5489, cardNum: 1972), Transaction(amount: 0.31, date: Date(timeIntervalSinceNow: -600000), longitude: -121.7476, latitutde: 38.5489, cardNum: 1972)]
    
    let locks = [BikeLock(id: "idTest0", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5449, longitude: -121.7448)), BikeLock(id: "idTest1", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5447, longitude: -121.7458)), BikeLock(id: "idTest2", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5511, longitude: -121.7468)), BikeLock(id: "idTest3", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5453, longitude: -121.7371)), BikeLock(id: "idTest4", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5439, longitude: -121.7481)), BikeLock(id: "idTest5", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5448, longitude: -121.7483)), BikeLock(id: "idTest6", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5416, longitude: -121.7484)), BikeLock(id: "idTest7", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5489, longitude: -121.7476)), BikeLock(id: "idTest8", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5399, longitude: -121.7581)), BikeLock(id: "idTest9", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5369, longitude: -121.5941)), BikeLock(id: "idTest10", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 38.5371, longitude: -121.7579))]
    
    var body: some View {
        ZStack {
            StaticDotBackground()
                .disabled(true)
            ScrollView(showsIndicators: false) {
                LargeTitle(title: "CycleLock", scanLock: $scanLock)
                    .offset(y: showMap ? screen().height * -0.3 : 0)
                    .zIndex(1)
                ZStack {
                    CityMap(showMap: $showMap, selectedLock: $selectedLock, annotations: locks)
                        .frame(width: screen().width, height: screen().height + 50)
                        .mask(
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: showMap ? screen().width : screen().width * 0.9, height: showMap ? screen().height + 50 : 200)
                        )
                        .offset(y: showMap ? screen().height * -0.19 : screen().height * -0.41)
                        .zIndex(4)
                        
                } .overlay(content: {
                    BouncyMapRotate(buttonScale: $buttonScale, showMap: $showMap)
                })
                VStack {
                    Divider()
                        .padding()
                    if selectedLock.id != "Not Selected" {
                        ActiveLock(showMap: $showMap, lock: $selectedLock, transactions: $transactions)
                        Divider()
                    }
                    Transactions(transactions: $transactions, showMap: $showMap, selectedTransaction: $selectedTransaction)
                        .offset(y: showMap ? screen().height * 0.5 : 0)
                }
                .zIndex(1)
                .offset(y: showMap ? 0 : screen().height * -0.82)
                Text("Current Lock: \(selectedLock.id)")
                    .foregroundColor(.gray)
                    .font(.caption)
                Text("Property of HALEN 2023")
                    .foregroundColor(.gray)
                    .font(.caption)
            } .sheet(isPresented: $scanLock, content: {
                CodeScannerView(codeTypes: [.qr], completion: { response in
                    if case let .success(result) = response {
                        selectedLock = locks.idMatches(with: result.string)
                        scanLock = false
                    }
                })
                    .presentationDetents([.medium])
                    .edgesIgnoringSafeArea(.all)
            })
        }
        .sheet(isPresented: $showTransactionSheet, onDismiss: {
            selectedTransaction = Transaction(amount: -5, date: Date.distantPast, longitude: 0, latitutde: 0, cardNum: 0)
        }, content: {
            TransactionPage(selectedTransaction: $selectedTransaction)
                .presentationDetents([.medium])
        })
        .onChange(of: selectedTransaction, perform: { selection in
            if selection?.amount != -5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    showTransactionSheet.toggle()
                })
            }
        })
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

extension [BikeLock] {
    func idMatches(with id: String) -> BikeLock {
        for lock in self {
            if lock.id == id {
                return lock
            }
        }
        return BikeLock(id: "Not Selected", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}
