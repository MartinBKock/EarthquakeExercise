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
    @Published var earthquakeDetail = [EarthquakeDetail]()

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
                    if self.read(filename: "earthquakes").count > 0 {
                        self.favorites = self.read(filename: "earthquakes")
                        self.allEarthquakes = self.favorites
                    }
                    
                    let filteredEarthquakes = result.features.filter { e in
                        !self.favorites.contains(where: {$0.id == e.id})
                    }
                    // where to put it
                    self.earthquakes = result.features
                    for e in filteredEarthquakes {
                        self.allEarthquakes.append(e)
                    }
                    
                }
            } catch {
                fatalError("YOU SUCK at converting from JSON!")
            }
        }
    }
    
    func fetchEarthquakeDetail(from url: URL) {
        Task {
            guard let rawEarthquakeDetailData = await NetworkService.getData(from: url) else {return}
        
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970
            do {
                let result = try decoder.decode(EarthquakeDetail.self, from: rawEarthquakeDetailData)
                DispatchQueue.main.async {
                    // where to put it
                    self.earthquakeDetail.removeAll()
                    self.earthquakeDetail.append(result)
      
                   
                    
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
         let size = MKMapSize(width: 30000, height: 30000)
        
        mapRect = MKMapRect(origin: MKMapPoint(x: point.x - size.width/2, y: point.y - size.height/2), size: size)
        
        return mapRect
    }
    
    func setFavorite(e: Feature) {
        if (favorites.contains(where: {$0.id != e.id})) {
            favorites.append(e)
            write(favorites, filename: "earthquakes")
        } else if favorites.count == 0 {
            favorites.append(e)
            write(favorites, filename: "earthquakes")
        }
    }
    
    func removeFavorite(at index: Int) {
        favorites.remove(at: index)
        write(favorites, filename: "earthquakes")
    }
    
    func removeFaveFromDetail(e: Feature) {
        if let index = favorites.firstIndex(where: {$0.id == e.id}) {
            favorites.remove(at: index)
            write(favorites, filename: "earthquakes")
        }
    }
    
    func removeFavoriteFromAllEarthquakes(from e: Feature) {
        
        let earth: Feature = earthquakes.first(where: {$0.id == e.id})!
        if let index = favorites.firstIndex(where: {$0.id == earth.id}) {
            favorites.remove(at: index)
            write(favorites, filename: "earthquakes")
        }
    }
    
    func write<T: Encodable>(_ object: T, filename: String) {
        let homeFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path = homeFolder?.appendingPathComponent("\(filename).json")
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: path!)
        } catch {
            print("Could not write file \(path!): \(error)")
        }
    }
    
    func read(filename: String) -> [Feature] {
        let homeFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path = homeFolder?.appendingPathComponent("\(filename).json")
        guard let data = try? Data(contentsOf: path!), !data.isEmpty else {
            return []
        }
        let decoder = JSONDecoder()
        return try! decoder.decode([Feature].self, from: data)
    }
    
    
    
    
}
