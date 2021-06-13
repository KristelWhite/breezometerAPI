//
//  MapViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 28.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit
import Mapbox
import RxSwift
import RxCocoa

class MapViewController: UIViewController , MGLMapViewDelegate {
    
    var mapView: MGLMapView!
    var rasterLayer: MGLRasterStyleLayer?

    @IBOutlet weak var numAQILabel: UILabel!
    @IBOutlet weak var updateMapButton: UIButton!
    @IBOutlet weak var aqiView: UIView!
    
    var disposeBag = DisposeBag()
    
    let viewModel = MapViewModel(API: APIProvider())
    
    let maxAqi = "/100"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let service = ServiceProvider()
//        
//        service.loadAirQuality{ [weak self] (result) in
//            guard let result = result, let _ = self else {
//                return
//            }
//            print(result)
//        }
        configurateMap()
        
//        self.viewModel.modelObservable.subscribe(onNext: {
//            model in
//            print(model.data?.indexes?.baqi?.aqiDisplay ?? "not model")
//        }
//        ).disposed(by: disposeBag)
        
        //при нажатие кнопки "обновить" координаты центра обновляеют геолокацию в логике
        updateMapButton.rx.tap.subscribe({
            event in self.viewModel.geolocation.onNext((self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude))
//            print("tab on updateButton")
            }).disposed(by: disposeBag)
         //если обновилась модель, выводится значение на экран
        self.viewModel.modelObservable.asObservable()
            .map{"\(String(describing: $0.data?.indexes?.baqi?.aqiDisplay ?? "no data"))\(self.maxAqi)"}.bind(to: (self.numAQILabel?.rx.text)!).disposed(by: disposeBag)
        
    }
    func configurateMap(){
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.streetsStyleURL)
         mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
         // про обновлении координат значение центра карты обновляется
        self.viewModel.geolocation.asObservable()
//            .do(onNext: {
//            lat, long in
//            print(lat, long)})
            .subscribe(onNext: {
                coordinates in
            self.mapView.setCenter(CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude), zoomLevel: 6.5, animated: false)
            }).disposed(by: disposeBag)
          
         mapView.delegate = self
         mapView.tintColor = .darkGray
         mapView.backgroundColor = .black
         
         view.addSubview(mapView)
         
         //add MarkerView
         let markerImageView = UIImageView(image: UIImage(named: "marker100"))
         markerImageView.center = view.center
         view.addSubview(markerImageView)
         
         view.addSubview(aqiView)
        
    }
     
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        // Add a new raster source and layer.
        let source = MGLRasterTileSource(identifier: "breezometer-tiles", tileURLTemplates: ["https://tiles.breezometer.com/v1/air-quality/breezometer-aqi/current-conditions/{z}/{x}/{y}.png?key=\(UrlParts.autoKey)&breezometer_aqi_color=indiper"], options: [ .tileSize: 256 ])
        let rasterLayer = MGLRasterStyleLayer(identifier: "breezometer-tiles", source: source)
        rasterLayer.rasterOpacity = NSExpression(forConstantValue: 0.7 as NSNumber)
        style.addSource(source)
//        style.addLayer(rasterLayer)
        // Insert the raster layer below the map's symbol layers.
        for layer in style.layers.reversed() {
            if !layer.isKind(of: MGLSymbolStyleLayer.self), !layer.isKind(of: MGLLineStyleLayer.self) {
                style.insertLayer(rasterLayer, above: layer)
                break
            }
        }
        self.rasterLayer = rasterLayer
    }
    
   
}
