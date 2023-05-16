//
//  StateController.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 15/05/2023.
//

import Foundation
import MapKit

class StateController: ObservableObject {
    @Published var earthquakes = [Feature]()
    @Published var favorites = [Feature]()
    @Published var allEarthquakes = [Feature]()

    init() {
        
        setEarthquakes(from: URL(string: EarthquakeSpan.Hour.rawValue)!)
        
    }
    
    func fetchEarthquakes(from url: URL) {
        Task {
            guard let rawEarthquakeData = await NetworkService.getData(from: url) else {return}
            let decoder = JSONDecoder()
  
            
            decoder.dateDecodingStrategy = .millisecondsSince1970
           
            
            
            do {
                let result = try decoder.decode(Earthquakes.self, from: rawEarthquakeData)
                DispatchQueue.main.async {
                    let filteredEarthquakes = result.features.filter { e in
                        !self.favorites.contains(where: {$0.id == e.id})
                    }
                    
                    // where to put it
                    self.earthquakes = result.features
                    self.allEarthquakes = filteredEarthquakes
                }
            } catch {
                fatalError("YOU SUCK at converting from JSON!")
            }
        }
    }
    
    func setEarthquakes(from url: URL) {
        if earthquakes.isEmpty {
            fetchEarthquakes(from: url)
            
        } else {
            earthquakes.removeAll()
            fetchEarthquakes(from: url)
        }
    }
    
    
    
        enum EarthquakeSpan: String, CaseIterable {
            case Hour =
                    "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
            case Day =
                    "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
            case Week =
                    "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson"
            case Month =
                    "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
        }
    
    func convertTimeToDK(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "da_DK")
        dateFormatter.dateFormat = "E d MMM y H:mm"
        
        return dateFormatter.string(from: date)
    }

     func fitOne(earthquake: Feature) -> MKMapRect {
        var mapRect: MKMapRect
        
         let point = MKMapPoint(earthquake.coordinate)
         let size = MKMapSize(width: 50000, height: 50000)
        
        mapRect = MKMapRect(origin: MKMapPoint(x: point.x - size.width/2, y: point.y - size.height/2), size: size)
        
        return mapRect
    }
    
    func setFavorite(e: Feature) {
        if (favorites.first(where: {$0.id != e.id}) == nil) {
            favorites.append(e)
        } else if (favorites.first(where: {$0.id != e.id}) != nil) {
            favorites.append(e)
        }
    }
    
    func removeFavorite(at index: Int) {
        favorites.remove(at: index)
    }
    
    func removeFavoriteFromAllEarthquakes(from e: Feature) {
        
        var earth: Feature = earthquakes.first(where: {$0.id == e.id})!
        if let index = favorites.firstIndex(where: {$0.id == earth.id}) {
            favorites.remove(at: index)
        }
    }
    
    
    
    
}
