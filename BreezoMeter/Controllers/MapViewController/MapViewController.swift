//
//  MapViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 28.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.loadImage()
        let service = ServiceProvider()
        
        service.loadAirQuality{ [weak self] (result) in
            guard let result = result, let _ = self else {
                return
            }
            print(result)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
