//
//  AirQualityModelView.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 01.06.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class AirQualityModelView {
    
//    let geolocation: BehaviorSubject<(CLLocationDegrees, CLLocationDegrees)> = BehaviorSubject<(CLLocationDegrees, CLLocationDegrees)>(value: (CLLocationDegrees(45.879876),CLLocationDegrees(45.879876)))
    let geolocation: BehaviorSubject<(Double, Double)> = BehaviorSubject<(Double, Double)>(value: (45.879896,45.879876)) 
    
    var model: AirQualityResponse?
    
    var modelObservable: BehaviorSubject<[AirQualityResponse]> = BehaviorSubject<[AirQualityResponse]>(value: [AirQualityResponse]())
    
    var disposeBag = DisposeBag()
    
    var place : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    
    
    init(tabelView: UITableView,API: APIProvider) {
        
        geolocation.subscribe(onNext: {
            lat, long in
            API.loadAirQuality(latitude: lat, longitude: long).subscribe(onNext: {
                model in
                self.modelObservable.onNext([model])
            }).disposed(by: self.disposeBag)
            
            
            }).disposed(by: disposeBag)
                
                
            
        
//        modelObservable.subscribe(onNext:{ modelArr in
//            self.model = modelArr[0]
//        }).disposed(by: disposeBag)
        
        
    }
}
