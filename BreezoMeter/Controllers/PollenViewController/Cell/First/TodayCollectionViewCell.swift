//
//  TodayCollectionViewCell.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 19.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weekday: UILabel!
    
    @IBOutlet weak var textLevel: UILabel!
    @IBOutlet weak var numLevel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weekday.lineBreakMode = .byWordWrapping
        weekday.numberOfLines = 0
        weekday.textAlignment = .center
        weekday.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        textLevel.textAlignment = .center
        textLevel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        numLevel.textAlignment = .center
        numLevel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.layer.cornerRadius = 15
    }

}
