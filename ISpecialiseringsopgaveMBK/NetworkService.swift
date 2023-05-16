//
//  NetworkService.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 15/05/2023.
//

import Foundation

class NetworkService {
    static func getData(from url: URL) async -> Data?{
        let session = URLSession.shared
        
        let (data, response) = try! await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return nil
        }
        return data
    }
}
