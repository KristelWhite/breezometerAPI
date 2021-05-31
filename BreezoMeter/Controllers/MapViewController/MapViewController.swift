//
//  MapViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 28.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController , MGLMapViewDelegate {
    var mapView: MGLMapView!
    var rasterLayer: MGLRasterStyleLayer?

   
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
        
        
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.darkStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         
        mapView.setCenter(CLLocationCoordinate2D(latitude: 45.5188, longitude: -122.6748), zoomLevel: 13, animated: false)
         
        mapView.delegate = self
        mapView.tintColor = .darkGray
        mapView.backgroundColor = .black
        
        view.addSubview(mapView)
        addAnnotation()
     
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
            if !layer.isKind(of: MGLSymbolStyleLayer.self) {
                style.insertLayer(rasterLayer, above: layer)
                break
            }
        }
        
         
        self.rasterLayer = rasterLayer
    }


   func addAnnotation() {
   let annotation = MGLPointAnnotation()
   annotation.coordinate = CLLocationCoordinate2D(latitude: 35.03946, longitude: 135.72956)
   annotation.title = "Kinkaku-ji"
   annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
    
   mapView.addAnnotation(annotation)
    
   // Center the map on the annotation.
   mapView.setCenter(annotation.coordinate, zoomLevel: 17, animated: false)
    
   // Pop-up the callout view.
   mapView.selectAnnotation(annotation, animated: true, completionHandler: nil)
   }
    
   func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
   return true
   }
    
   func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
   if (annotation.title! == "Kinkaku-ji") {
   // Callout height is fixed; width expands to fit its content.
   let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
   label.textAlignment = .right
   label.textColor = UIColor(red: 0.81, green: 0.71, blue: 0.23, alpha: 1)
   label.text = "金閣寺"
    
   return label
   }
    
   return nil
   }
    
   func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
   return UIButton(type: .detailDisclosure)
   }
    
   func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
   // Hide the callout view.
   mapView.deselectAnnotation(annotation, animated: false)
    
   // Show an alert containing the annotation's details
   let alert = UIAlertController(title: annotation.title!!, message: "A lovely (if touristy) place.", preferredStyle: .alert)
   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
   self.present(alert, animated: true, completion: nil)
    
   }

}
