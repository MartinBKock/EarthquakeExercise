//
//  DetailMap.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 16/05/2023.
//

import SwiftUI
import MapKit

struct DetailMap: View {
    @EnvironmentObject var stateController: StateController
    @State private  var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion()

    var earthquake: Feature
    @State var mapRect: MKMapRect = MKMapRect()
    var body: some View {
        
        NavigationStack {
            VStack {
                VStack {
                    // Add your content here
                    ZStack {
                        Rectangle()
                            .fill(earthquake.properties.mag >= 5.0 ? Color.red : Color.green) // Change color based on earthquake magnitude
                            .frame(maxWidth: .infinity, maxHeight: 200)
                        Text(earthquake.properties.place)
                            .font(.title)
                            .offset(y: 20)
                    }
                }
                .ignoresSafeArea()
                .padding(.bottom, -160)
                
                // Existing VStack with Map
                Map(mapRect: $mapRect, annotationItems: stateController.allEarthquakes) { earthquake in
                    MapMarker(coordinate: earthquake.coordinate, tint: .red)
                }
                .task {
                    mapRect = stateController.fitOne(earthquake: earthquake)
                    print(mapRect)
                }
                .ignoresSafeArea()
            }
            .toolbar(.hidden, for: .tabBar)
        }

    }
}

struct DetailMap_Previews: PreviewProvider {
    static var previews: some View {
        var earthquake: Feature = Feature(type: "", properties: Properties(mag: 0, place: "4km NW of Palomar Observatory, CA", time: Date(), updated: 12312313, tz: 0, url: "", detail: "", felt: 0, cdi: 0, mmi: 0, alert: "", status: "", tsunami: 0, sig: 0, net: "", code: "", ids: "", sources: "", types: "", nst: 0, dmin: 0, rms: 0, gap: 0, magType: "", type: "", title: ""), geometry: Geometry(type: GeometryType.point, coordinates: [123213, 3121]), id: "", favorite: true)
        DetailMap(earthquake: earthquake).environmentObject(StateController())
    }
}
