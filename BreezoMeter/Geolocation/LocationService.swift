//
//  LocationService.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 06.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift


final class LocationService: NSObject, CLLocationManagerDelegate  {
    private let locationManager = CLLocationManager()
    let service = ServiceProvider()
    
    var currentGeolocation = BehaviorSubject<(lattitude: CLLocationDegrees, longitude: CLLocationDegrees)>(value: (45.756765,47.785788))
    
    
    override init() {
        super.init()
        configurate()
    }
    
    private func configurate() {
        locationManager.delegate = self
        //разрешаем работу в фоне
        locationManager.allowsBackgroundLocationUpdates = true
        //запрещаем уходить в паузы при не изменении локации
        locationManager.pausesLocationUpdatesAutomatically = false
        
    }
    //алерт о запросе прав
    func requestPermission() {
        locationManager.requestAlwaysAuthorization()

    }
    private func setActive(_ value: Bool) {
        if value {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = 100
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.distanceFilter = 3000
        }
    }
    
    func start() {
        setActive(true)
        locationManager.startUpdatingLocation()
        //перезапуск приложения в выгруженом состоянии для доставки новых данных
        locationManager.startMonitoringSignificantLocationChanges()
        
        service.loadPollen{ [weak self] (result) in
        guard let result = result, let _ = self else {
            return
        }
    }
    
}
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        currentGeolocation.onNext(((locations.last?.coordinate.latitude)!, (locations.last?.coordinate.longitude)!))
        
        print(self.locationManager.location?.coordinate ?? "нет")
        
        if let coordinates = self.locationManager.location?.coordinate {
            service.setLocation(lat: coordinates.latitude, lon: coordinates.longitude)
            }
        print("update location")
        print(service.latLocation, service.lonLocation)
        service.loadPollen{ [weak self] (result) in
            guard let result = result, let _ = self else {
                return
            }
//            print(result)
        }
        
//        let userDefaults = UserDefaults.standard
//        let key = "location"
//        let count = userDefaults.integer(forKey: key) + 1
//        userDefaults.set(count, forKey: key)
//        userDefaults.synchronize()
//        print("didUpdateLocations #\(count)")
    }
//    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print("error::: \(error)")
//        locationManager.stopUpdatingLocation()
//
//    }
}
