//
//  EarthquakeView.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 15/05/2023.
//

import SwiftUI

struct EarthquakeView: View {
    @EnvironmentObject var stateController: StateController
    @State var sort: Bool = false
    @State var path = NavigationPath()
    
    private var fave: [Feature] {
        if !sort {
         return   stateController.favorites.sorted {
                $0.properties.mag < $1.properties.mag
            }
            }else {
             return   stateController.favorites.sorted{
                    $0.properties.time < $1.properties.time
                }
        }
    }
        var body: some View {
            
            NavigationStack(path: $path) {
                    List {
                        Section("All interesting earthquakes") {
                            ForEach(fave) {e in
                                NavigationLink(value: e, label: {
                                    ComponentView(mag: e.properties.mag, time: stateController.convertTimeToDK(from: e.properties.time), place: e.properties.place, id: e.id)
                                })
                                .swipeActions(allowsFullSwipe: true) {
                                    Button {
                                        if let index = stateController.favorites.firstIndex(where: {$0.id == e.id}) {
                                           
                                            stateController.removeFavorite(at: index)
                                        }
                                    } label: {
                                        Image(systemName: "xmark")
                                    }.tint(.red)

                                }
                            
                            }
                         
                            .frame(height: 100)
                            .listRowSeparator(.hidden)
                        }
                    
                        Section("All earthquakes in category") {
                            ForEach(stateController.earthquakes.sorted {
                                $0.properties.mag < $1.properties.mag
                            }) { e in
                                NavigationLink(value: e, label: {
                                    ComponentView(mag: e.properties.mag, time: stateController.convertTimeToDK(from: e.properties.time), place: e.properties.place, id: e.id)
                                })
                                .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                        stateController.setFavorite(e: e)
                                    } label: {
                                        Image(systemName: "checkmark")
                                    }.tint(.green)
                                    Button {
                                        stateController.removeFavoriteFromAllEarthquakes(from: e)
                                    } label: {
                                        Image(systemName: "xmark")
                                    }.tint(.red)
                                    
                                }
                            }
                            .frame(height: 100)
                        .listRowSeparator(.hidden)
                        }
                        
                    }
                    .navigationDestination(for: Feature.self) { e in
                        DetailMap(path:$path, earthquake: e)
                    }
                    .listStyle(.plain)
                    .toolbar {
                        if stateController.favorites.count > 1 {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Toggle("Sort interesting after date or mag", isOn: $sort)
                                    .toggleStyle(.switch)
                            }
                        }
                    } .navigationTitle("Earthquakes")
                }
        }
}

struct EarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeView().environmentObject(StateController())
    }
}
