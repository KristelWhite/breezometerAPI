//
//  File.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 20.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    func applyShadow(radius: CGFloat, opacity: Float, offsetW: Int, offsetH: Int) {
        let color: UIColor = .black
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: offsetW, height: offsetH)
        self.layer.masksToBounds = false
    }
}
