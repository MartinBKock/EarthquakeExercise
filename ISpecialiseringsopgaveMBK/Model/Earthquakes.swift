//
//  Eearthquakes.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 15/05/2023.
//

import Foundation
import CoreLocation

// MARK: - Earthquakes
struct Earthquakes: Codable {
    let type: String
    let metadata: Metadata
    let features: [Feature]
    let bbox: [Double]?
}

// MARK: - Feature
struct Feature: Codable, Identifiable {
    let type: String
    let properties: Properties
    let geometry: Geometry
    let id: String
    var favorite: Bool?
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
    case feature = "Feature"
}

// MARK: - Properties
struct Properties: Codable {
    let mag: Double
    let place: String
    let time: Date
    let updated: Int
    let tz: Int?
    let url: String
    let detail: String
    let felt: Int?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String
    let tsunami, sig: Int
    let net, code, ids, sources: String
    let types: String
    let nst: Int?
    let dmin: Double?
    let rms: Double
    let gap: Double?
    let magType: String
    let type: String
    let title: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let generated: Int
    let url: String
    let title: String
    let status: Int
    let api: String
    let count: Int
}

// MARK: - Extension for CLLocation
extension Feature {
    var coordinate: CLLocationCoordinate2D {
        if geometry.coordinates.count >= 2 {
            let latitude = geometry.coordinates[1]
            let longitude = geometry.coordinates[0]
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return CLLocationCoordinate2D()
        }
    }
   
}
extension Feature {
    mutating func setFav(_ b: Bool) {
        self.favorite = b
    }
}
