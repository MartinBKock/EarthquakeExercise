//
//  EarthquakeView.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 15/05/2023.
//

import SwiftUI

struct EarthquakeView: View {
    @EnvironmentObject var stateController: StateController
    
        var body: some View {
            
            NavigationStack {
             
                
                
                    List {
                        Section("All Favorites") {
                            ForEach(stateController.favorites.sorted {
                                $0.properties.mag < $1.properties.mag
                            }) {e in
                                NavigationLink {
                                    DetailMap(earthquake: e)
                                    
                                    
                                } label: {
                                    ComponentView(mag: e.properties.mag, time: stateController.convertTimeToDK(from: e.properties.time), place: e.properties.place, id: e.id)
                                }
                                
                                .swipeActions(allowsFullSwipe: false) {
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
                                NavigationLink {
                                    DetailMap(earthquake: e)
                                    
                                    
                                } label: {
                                    ComponentView(mag: e.properties.mag, time: stateController.convertTimeToDK(from: e.properties.time), place: e.properties.place, id: e.id)
                                }
                                
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
                    .listStyle(.plain)
                    
                    
                    
                }
                .navigationTitle("Earthquakes")
                
                
            
           
            
        }
}

struct EarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeView().environmentObject(StateController())
    }
}
