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
    let geolocation: BehaviorSubject<(Double, Double)> = BehaviorSubject<(Double, Double)>(value: (45.879896,45.879876))
    
    var model: AirQualityResponse?
    
    var modelObservable: PublishSubject<AirQualityResponse> = PublishSubject<AirQualityResponse>()
    
    var disposeBag = DisposeBag()
    
    let maxAqi = "/100"
    
    var aqi : BehaviorSubject<String> = BehaviorSubject<String>(value: "58/100")
 
    init(API: APIProvider) {
       
      
        geolocation.subscribe(onNext: { 
            lat, long in
            API.loadAirQuality(latitude: lat, longitude: long).subscribe(onNext: {
                model in
                self.modelObservable.onNext(model)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
