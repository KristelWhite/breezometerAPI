//
//  PollenViewModel.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 12.06.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class PollenViewModel {
    
    let geolocation: BehaviorSubject<(latitude: CLLocationDegrees, longitude: CLLocationDegrees)> = BehaviorSubject<(latitude: CLLocationDegrees, longitude: CLLocationDegrees)>(value: (CLLocationDegrees(52.5177795),CLLocationDegrees( 13.4098392)))

    
//    var model: AirQualityResponse?
    struct Forecast: Codable {
        let intAqi: Int?
        let stringAqi: String?
        let color: String?
    }
    struct PollenTypes: Codable {
        let tree: [Forecast]
        let grass: [Forecast]
        let weed: [Forecast]
    }
    var pollenForecast: PollenTypes?
    
//    enum State: String {
//          case tree = "Tree"
//          case weed = "Weed"
//          case grass = "Grass"
//      }
//    let state : BehaviorSubject<State> = BehaviorSubject<State>(value: State.tree)
//    
    var modelObservable: BehaviorSubject<[PollenResponse]> = BehaviorSubject<[PollenResponse]>(value: [PollenResponse]())
    
    var disposeBag = DisposeBag()
    
    var place : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    
    
    init(tabelView: UITableView,API: APIProvider) {
        
        geolocation.subscribe(onNext: {
            lat, long in
            API.loadPollen(latitude: lat, longitude:  long).subscribe(onNext: {
                model in
                //костыль
                var arrModel: [PollenResponse] = []
                arrModel.append(model)
                arrModel.append(model)
                self.modelObservable.onNext(arrModel)
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
            
        
        self.modelObservable.filter{
        arrmodel in
            arrmodel.count > 1
        } .flatMap {
            arrPollen -> Observable<PollenTypes> in
            print("2")
            let pollen  = arrPollen[0]
            var typesPollen: PollenTypes
            var treeForecast: [Forecast] = []
            var grassForecast: [Forecast] = []
            var weedForecast: [Forecast] = []
            
            for i in 0...2 {
                treeForecast.append(Forecast.init(intAqi:  pollen.data?[i].types?.tree?.index?.value, stringAqi: pollen.data?[i].types?.tree?.index?.category,
                    color: pollen.data?[i].types?.tree?.index?.color ))
                
            }
            print(treeForecast)
            for i in 0...2 {
                grassForecast.append(Forecast.init(intAqi: pollen.data?[i].types?.grass?.index?.value, stringAqi: pollen.data?[i].types?.grass?.index?.category,
                color: pollen.data?[i].types?.grass?.index?.color))
                
            }
            print(grassForecast)
            for i in 0...2 {
               weedForecast.append(Forecast.init(intAqi:  pollen.data?[i].types?.weed?.index?.value, stringAqi: pollen.data?[i].types?.weed?.index?.category,
                color: pollen.data?[i].types?.weed?.index?.color))
                
            }
            print(weedForecast)
            typesPollen = PollenTypes.init(tree: treeForecast, grass: grassForecast, weed: weedForecast)
            
            print("3")
            return Observable.just(typesPollen)
            }.bind(onNext: {
            typesPollen in
            self.pollenForecast =  typesPollen

        }).disposed(by: disposeBag)
    }
}
