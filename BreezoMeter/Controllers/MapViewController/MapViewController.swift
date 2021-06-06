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
    
    let geolocation: (latitude: CLLocationDegrees, longitude: CLLocationDegrees) = (45.876548, 45.876576)

    var disposeBag = DisposeBag()
    
    let viewModel = MapViewModel(API: APIProvider())
    
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
        
        
        
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.darkStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: geolocation.latitude, longitude: geolocation.longitude), zoomLevel: 13, animated: false)
         
        mapView.delegate = self
        mapView.tintColor = .darkGray
        mapView.backgroundColor = .black
        
        view.addSubview(mapView)
        
        //add MarkerView
        let markerImageView = UIImageView(image: UIImage(named: "marker100"))
        markerImageView.center = view.center
        view.addSubview(markerImageView)
        
        view.addSubview(aqiView)
        
        
        updateMapButton.rx.tap.asObservable().subscribe({
            event in self.viewModel.geolocation.onNext((self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude))
            }).disposed(by: disposeBag)
         
       
         
        
        viewModel.modelObservable.asObservable().subscribe(onNext: { model in
            self.numAQILabel.text = model.data?.indexes?.baqi?.aqiDisplay
            
        }).disposed(by: disposeBag)
        
    }
     
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        // Add a new raster source and layer.
        let source = MGLRasterTileSource(identifier: "breezometer-tiles", tileURLTemplates: ["https://tiles.breezometer.com/v1/air-quality/breezometer-aqi/current-conditions/{z}/{x}/{y}.png?key=\(UrlParts.autoKey)&breezometer_aqi_color=red_green"], options: [ .tileSize: 256 ])
        let rasterLayer = MGLRasterStyleLayer(identifier: "breezometer-tiles", source: source)
        rasterLayer.rasterOpacity = NSExpression(forConstantValue: 0.65 as NSNumber)
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

    
    
    @IBAction func TouchUpInsideUpdateMap(_ sender: Any) {
        print("touch updateMap")
        numAQILabel.text = "50/100"
    }
    

//    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//    // Only show callouts for `Hello world!` annotation.
//    return annotation.responds(to: #selector(getter: MGLAnnotation.title)) && annotation.title! == "Hello world!"
//    }
//
//    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
//    // Instantiate and return our custom callout view.
//    return CustomCalloutView(representedObject: annotation)
//    }
//
//    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
//    // Optionally handle taps on the callout.
//    print("Tapped the callout for: \(annotation)")
//
//    // Hide the callout.
//    mapView.deselectAnnotation(annotation, animated: true)
//    }
   
}
