//
//  GeolicationService.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 09.06.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import CoreLocation

class GeolocationService {
    
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
}
