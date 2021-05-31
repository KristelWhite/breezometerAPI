//
//  UIImageView.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 30.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage() {
        guard let url = URL(string: "https://tiles.breezometer.com/v1/air-quality/breezometer-aqi/current-conditions/1/2/1.png?key=ca0fc635ea2d476b97d14bcfc606f634&breezometer_aqi_color=indiper") else {
            print("no correct url image")
            return
        }
        

        let cache = URLCache.shared
        let request = URLRequest(url: url)

        if let imageData = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: imageData)
        } else {
            URLSession.shared.dataTask(with: request) { (data, response, _) in
                DispatchQueue.main.async {
                    guard let data = data, let response = response else {
                        return
                    }
                    let cacheRepsonse = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cacheRepsonse, for: request)
                    self.image = UIImage(data: data)
                }
                
            }.resume()
        }

    }
}
