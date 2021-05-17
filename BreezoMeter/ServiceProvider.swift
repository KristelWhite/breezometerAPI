//
//  ServiceProvider.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 05.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import CoreLocation

enum ServerError: Error {
    case noDataProvided
    case failedToDecode
}
struct AutorizationData {
    let baseUrl = "https://api.breezometer.com/pollen/v2/forecast/"
    let autoKey = "f43c1b49adba4760a68f4e9fb46fa94e"
}
class ServiceProvider {

    // MARK: - Properties
    let autoData = AutorizationData()
    var latLocation: CLLocationDegrees = 48.857456
    var lonLocation: CLLocationDegrees = 2.354611
    var dayNumber: Int = 3
    
    // MARK: - Methods
    
    func loadInfo(completion: @escaping (ListResponse?) -> Void) {
//        guard let url = URL(string:  "\(autoData.baseUrl)daily?lat=\(Double(latLocation))&lon=\(Double(latLocation))&days=\(dayNumber)&key=\(autoData.autoKey)") else {
//            return
//        }
        guard let url = URL(string:  "https://api.breezometer.com/pollen/v2/forecast/daily?lat=\(self.latLocation)&lon=\(self.lonLocation)&days=3&key=\(autoData.autoKey)") else {
            return
        }
        print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                return completion(nil)
            }
            
            do {
//                let json = String(data: data, encoding: String.Encoding.utf8)
//                print(json)
                let result = try decoder.decode(ListResponse.self, from: data)
                DispatchQueue.main.async {
//                    print(result)
                    completion(result)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    func setLocation(lat: CLLocationDegrees, lon: CLLocationDegrees) -> Void {
        self.latLocation = lat
        self.lonLocation = lon
    }
}

struct ListResponse: Codable {
    let metadata: String?
    let data: [DayModel]?
    let error: String?
}
struct DayModel : Codable {
    let date: String?
    let indexId: String?
    let indexDisplayName: String?
    let types: Types?
    struct Types: Codable {
        let grass: Allergen?
        let tree: Allergen?
        let weed: Allergen?
    }
    enum CodingKeys: String, CodingKey {
        case date
        case indexId = "indexId"
        case indexDisplayName = "indexDisplayName"
        case types
    }
}
struct Allergen: Codable {
    let displayName: String?
    let inSeason: Bool?
    let dataAvailable: Bool?
    let index: Index?
    struct Index: Codable {
        let value: Int?
        let category: String?
        let color: String?
    }
}
