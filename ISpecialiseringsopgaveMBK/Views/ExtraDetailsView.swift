//
//  ExtraDetailsView.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 17/05/2023.
//

import SwiftUI

struct ExtraDetailsView: View {
    @EnvironmentObject var stateController: StateController
    @Binding var path: NavigationPath
    var earthquake: Feature
    @State var detail: EarthquakeDetail = EarthquakeDetail(type: "feature", id: "23", properties: nil)
    @State var showLoading: Bool = true
    @State var showAlert: Bool = false

    var isFave: Bool {
        stateController.favorites.contains(where: {$0.id == earthquake.id})
    }
    var body: some View {
        VStack {
            if showLoading {
                Text("Loading up the detail page...")
                    .progressViewStyle(.circular)
            } else {
                VStack(alignment: .leading) {
                    Text("Type: \(detail.properties?.products?.origin?.first?.properties?.eventType ?? "Earthquake") ")
                        .font(.headline)
                    Text("Time: \(stateController.convertTimeToDK(from: detail.properties?.time ?? Date()))")
                        .font(.headline)
                    Text("Place: \(detail.properties?.place ?? earthquake.properties.place)")
                        .font(.headline)
                    Text("Depth \(detail.properties?.products?.origin?.first?.properties?.depth ?? "30") km")
                        .font(.headline)
                    Text("Magnitude: \(detail.properties?.mag ?? 0)")
                        .font(.headline)
                    
                    
                }.offset(y: -150)
                
                VStack {
                    if !isFave {
                        Text("Set earthquake as interesting")
                            .font(.headline)
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                showAlert.toggle()
                            }
                    } else {
                        Text("Remove from interesting")
                            .font(.headline)
                        Image(systemName: "heart.slash")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                showAlert.toggle()
                            }
                    }
                }.padding(.bottom, 40)
                VStack {
                    Button {
                        path.removeLast()
                    } label: {
                        Text("Go back to frontpage")
                    }

                }
                .alert(isPresented: $showAlert) {
                    if !isFave {
                        return Alert(title: Text("Add to interesting?"), primaryButton: .default(Text("Add")) {
                            stateController.setFavorite(e: earthquake)
                            
                        }, secondaryButton: .cancel())
                    } else {
                       return Alert(title: Text("Remove from interesting?"), primaryButton: .destructive(Text("Remove")) {
                            stateController.removeFaveFromDetail(e: earthquake)
                        }, secondaryButton: .cancel())
                    }
                    
                }
            }
        }
        .onAppear {
            stateController.fetchEarthquakeDetail(from: URL(string: earthquake.properties.detail)!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                detail = stateController.earthquakeDetail[0]
                showLoading.toggle()
            }
        }
    }
}

struct ExtraDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        var earthquake: Feature = Feature(type: "", properties: Properties(mag: 0, place: "4km NW of Palomar Observatory, CA", time: Date(), updated: 12312313, tz: 0, url: "", detail: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/ok2023jlkb.geojson", felt: 0, cdi: 0, mmi: 0, alert: "", status: "", tsunami: 0, sig: 0, net: "", code: "", ids: "", sources: "", types: "", nst: 0, dmin: 0, rms: 0, gap: 0, magType: "", type: "", title: ""), geometry: Geometry(type: GeometryType.point, coordinates: [123213, 3121]), id: "", favorite: true)
        ExtraDetailsView(path: .constant(NavigationPath()), earthquake: earthquake, detail: EarthquakeDetail(type: "Feature", id: "213213", properties: nil)).environmentObject(StateController())
    }
}
