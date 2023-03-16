//
//  CityMap.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/11/23.
//

import SwiftUI
import MapKit

struct CityMap: View {
    
    @Binding var showMap: Bool
    @Binding var selectedLock: BikeLock
    
    @State private var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 38.5447,
                        longitude: -121.7440),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.02,
                        longitudeDelta: 0.02)
                    )
    
    var annotations: [BikeLock]
    
    func getLockColor(id: String) -> Color {
        if selectedLock.id == id {
            return Color("CrayolaBlue")
        }
        return Color("GlauciousBlue")
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, interactionModes: showMap ? .all : .zoom, annotationItems: annotations) { map in
                MapAnnotation(coordinate: map.coordinate, content: {
                    Image(systemName: "lock.square.fill")
                        .font(.title2)
                        .foregroundStyle(.white, getLockColor(id: map.id))
                })
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CityMap_Previews: PreviewProvider {
    static var previews: some View {
        CityMap(showMap: .constant(false), selectedLock: .constant(BikeLock(id: "Not Selected", inUse: false, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))), annotations: [])
    }
}

struct BikeLock: Identifiable {
    var id: String
    let inUse: Bool
    var coordinate: CLLocationCoordinate2D
//    init() {
//        var hasher = Hasher()
//        hasher.combine(id)
//        id = "\(hasher.finalize())"
//    }
}

func compareStringToUUID(string: String, id: UUID) -> Bool {
    if UUID(uuidString: string) ?? UUID() == id {
        return true
    }
    return false
}
