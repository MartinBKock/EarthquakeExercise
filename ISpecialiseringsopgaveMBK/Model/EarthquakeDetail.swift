//
//  EarthquakeDetail.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 17/05/2023.
//

import Foundation

// MARK: - EarthquakeDetail
struct EarthquakeDetail: Codable, Identifiable {
    let type: String
    let id: String
    let properties: EarthquakeDetailProperties?
}

// MARK: - EarthquakeDetailProperties
struct EarthquakeDetailProperties: Codable {
    let mag: Double?
    let time: Date
    let place: String?
    let gap: Double?
    let tsunami: Int?
    let magType, type, title: String?
    let products: Products?
}

// MARK: - Products
struct Products: Codable {
    let origin: [Origin]?
}

// MARK: - Origin
struct Origin: Codable {
    let indexid: String?
      let indexTime: Int?
      let id, type, code, source: String?
      let updateTime: Int?
      let status: String?
      let properties: OriginProperties?
      let preferredWeight: Int?
}

// MARK: - OriginProperties
struct OriginProperties: Codable {
    let azimuthalGap, depth, evaluationStatus, eventType: String?
    let eventParametersPublicID, eventsource, eventsourcecode, eventtime: String?
    let latitude, latitudeError, longitude, longitudeError: String?
    let magnitude, magnitudeError, magnitudeNumStationsUsed, magnitudeSource: String?
    let magnitudeType, minimumDistance, numPhasesUsed, numStationsUsed: String?
    let title: String?
    let verticalError: String?
}
