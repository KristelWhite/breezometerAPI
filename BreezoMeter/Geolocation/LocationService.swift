//
//  LocationService.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 06.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import CoreLocation



final class LocationService: NSObject, CLLocationManagerDelegate  {
    private let locationManager = CLLocationManager()
    let service = ServiceProvider()
    
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
    
    func start() {
//        setActiveMode(true)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        print(locationManager.location?.coordinate ?? "нет")
//        motionManager.startActivityUpdates(to: .main, withHandler: { [weak self] activity in
//            self?.setActiveMode(activity?.cycling ?? false)
//        })
    }
    
    private func setActiveMode(_ value: Bool) {
        if value {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 100
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.distanceFilter = CLLocationDistanceMax
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        print(locationManager.location?.coordinate ?? "нет")
        
        if let coordinates = locationManager.location?.coordinate {
            service.setLocation(lat: coordinates.latitude, lon: coordinates.longitude)
            }
        print(service.latLocation, service.lonLocation)
        service.loadInfo{ [weak self] (result) in
            guard let result = result, let _ = self else {
                return
            }
            print(result)
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
