//
//  MapViewModel.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 03.06.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class MapViewModel {
    let geolocation: BehaviorSubject<(latitude: CLLocationDegrees, longitude: CLLocationDegrees)> = BehaviorSubject<(latitude: CLLocationDegrees, longitude: CLLocationDegrees)> (value: (45.879896,45.879876))
    
    var model: AirQualityResponse?
    
    var modelObservable: BehaviorSubject<AirQualityResponse> = BehaviorSubject<AirQualityResponse>(value: AirQualityResponse.init(metadata: nil, data: nil, error: nil))
    
    var disposeBag = DisposeBag()
    
  

 
    init(API: APIProvider) {
//        APIProvider().loadAirQuality(latitude: 45.879896, longitude: 45.879876).subscribe(onNext: {model in print(model)}, onError: {error in print(error)}, onCompleted: {print("complrted")}, onDisposed: {print("disposed")})
       
        geolocation.subscribe(onNext: {
            lat, long in
            API.loadAirQuality(latitude: lat, longitude: long).catch{error in
                print(error)
                return Observable.just(AirQualityResponse.init(metadata: nil, data: nil, error: nil))

            }.do(onNext: {model in
                print(model)
            },  onError: {model in
                print(model)
            },  onCompleted: {
                print("completed")
            }, onDispose: {print("dispose")})
                .bind(onNext: {
                    model in
                    self.modelObservable
                    .onNext(model)
                }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
//        geolocation.flatMap({coordinates in
//            APIProvider().loadAirQuality(latitude: coordinates.latitude, longitude: coordinates.longitude)
//        }).bind(onNext: {model in
//            self.modelObservable
//                .onNext(model)
//        }).disposed(by: disposeBag)
        
    }
}
