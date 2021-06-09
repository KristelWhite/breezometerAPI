//
//  APIProvider.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 01.06.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift

class APIProvider {
    let dayNumber = 3
    var latLocation: CLLocationDegrees = 48.857456
    var lonLocation: CLLocationDegrees = 2.354611
    
    func loadAirQuality(latitude: CLLocationDegrees, longitude: CLLocationDegrees)-> Observable<AirQualityResponse> {
        return Observable<AirQualityResponse>.create { observer in
            guard let url = URL(string:    "https://api.breezometer.com/air-quality/v2/current-conditions?lat=\(latitude)&lon=\(longitude)&key=\(UrlParts.autoKey)&features=breezometer_aqi,local_aqi,health_recommendations,sources_and_effects,pollutants_concentrations,pollutants_aqi_information") else {
                    observer.onError(NetworkError.noDataProvided)
                    return Disposables.create()
                }
                print(url.absoluteString)

                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let data = data else {
                    observer.onError(NetworkError.invalidHttpBodyData)
                        print("no data")
                        return
                    }
                    print("is data")
                    do {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("----------------------------------------------")
                        print(json)
                        guard let result = try? decoder.decode(AirQualityResponse.self, from: data) else {
                            print ( "AirQualityResponse не декодируется")
                            observer.onError(NetworkError.failedToDecode)
                            return
                            
                        }
                        
                        observer.onNext(result)
                        observer.onCompleted()
                    }
            }.resume()
            return Disposables.create()
            }
        
        }
    
    
    
    

}
