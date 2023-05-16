//
//  ContentView.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 15/05/2023.
//

import SwiftUI

struct ContentView: View {
    

    @EnvironmentObject var stateController: StateController
    
   
    
    
    
    var body: some View {
        TabView {
            EarthquakeView()
                .tabItem {
                    Label("1 Hour", systemImage: "map")
                }
                .onAppear {
                    stateController.setEarthquakes(from: URL(string: StateController.EarthquakeSpan.Hour.rawValue)!)
                }
                .tag("hour")
                
                   
                
            EarthquakeView()
                .tabItem {
                    Label("1 Day", systemImage: "map")
                }
                .onAppear {
                    stateController.setEarthquakes(from: URL(string: StateController.EarthquakeSpan.Day.rawValue)!)
                }.tag("day")
            
            EarthquakeView()
                .tabItem {
                    Label("1 week", systemImage: "map")
                }
                .onAppear {
                    stateController.setEarthquakes(from: URL(string: StateController.EarthquakeSpan.Week.rawValue)!)
                }.tag("week")
            
            EarthquakeView()
                .tabItem {
                    Label("1 month", systemImage: "map")
                }
                .onAppear {
                    stateController.setEarthquakes(from: URL(string: StateController.EarthquakeSpan.Month.rawValue)!)
                }.tag("month")
                
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(StateController())
    }
}
