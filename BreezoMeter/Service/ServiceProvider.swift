//
//  ServiceProvider.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 05.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit
import CoreLocation

enum ServerError: Error {
    case noDataProvided
    case failedToDecode
}
struct AutorizationData {
    let baseUrl = "https://api.breezometer.com/pollen/v2/forecast/"
    let autoKey = "ca0fc635ea2d476b97d14bcfc606f634"
}
class ServiceProvider {

    // MARK: - Properties
    let autoData = AutorizationData()
    var latLocation: CLLocationDegrees = 48.857456
    var lonLocation: CLLocationDegrees = 2.354611
    var dayNumber: Int = 3
    
    // MARK: - Methods
    
    func loadPollen(completion: @escaping (PollenResponse?) -> Void) {
        guard let url = URL(string:  "https://api.breezometer.com/pollen/v2/forecast/daily?lat=\(self.latLocation)&lon=\(self.lonLocation)&days=3&key=\(autoData.autoKey)") else {
            return
        }
//        print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                return completion(nil)
            }
            
            do {
//                let json = String(data: data, encoding: String.Encoding.utf8)
//                print(json)
                let result = try decoder.decode(PollenResponse.self, from: data)
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
    
    func loadMap(completion: @escaping (UIImageView) -> Void) {
        
    }
    
     func loadAirQuality(completion: @escaping (AirQualityResponse?) -> Void) {
            guard let url = URL(string:  "https://api.breezometer.com/air-quality/v2/current-conditions?lat=\(self.latLocation)&lon=\(self.lonLocation)&key=\(autoData.autoKey)&features=breezometer_aqi,local_aqi,health_recommendations,sources_and_effects,pollutants_concentrations,pollutants_aqi_information") else {
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
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("----------------------------------------------")
                    print(json)
                    guard let result = try? decoder.decode(AirQualityResponse.self, from: data) else {
                        print ( "AirQualityResponse не декодируется")
                        return
                        
                    }

                    DispatchQueue.main.async {
                        completion(result)
                    }
                } catch {
                    completion(nil)
                }
            }.resume()
    }
    
}

//struct AirQuality: Codable {
//    let date: Date?
//    struct Date: Codable {
//        let data_avaliable: Bool
//        let indexes: Indexes?
//        let pollutants: Pollutants?
//        struct Indexes: Codable {
//            let baqi: Baqi?
//            struct Baqi: Codable {
//                let aqi: Int?
//                let aqiDisplay: String?
//                let color: String?
//                let category: String?
//            }
//        }
//        struct Pollutants: Codable {
//            
//        
//        }
//
//    }
//    
//}
