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

class AirQualityViewModel {
    
    let geolocation: BehaviorSubject<(latitude: CLLocationDegrees, longitude: CLLocationDegrees)> = BehaviorSubject<(latitude: CLLocationDegrees, longitude: CLLocationDegrees)>(value: (CLLocationDegrees(52.5177795),CLLocationDegrees( 13.4098392)))

    
//    var model: AirQualityResponse?

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
//        вывод значения place
        place.subscribe(onNext: {
            text in
            print(text)
            }).disposed(by: disposeBag)
//находим координаты выбранного места
        place.filter{$0 != ""}.distinctUntilChanged{ $0 == $1 }.bind(onNext: {text in
            GeolocationService().coordinates(forAddress: text) {
                (location) in
                guard let location = location else {
                    // Handle error here.
                    print("adress error")
//                    вызвать уведомление
                    return
                    }
            self.geolocation.onNext((location.latitude,location.longitude))
            }
            }).disposed(by: disposeBag)
            
        
//        modelObservable.subscribe(onNext:{ modelArr in
//            self.model = modelArr[0]
//        }).disposed(by: disposeBag)
        
        
    }
}
