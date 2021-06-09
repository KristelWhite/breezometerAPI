//
//  BrethQualityTableViewCell.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 29.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class BrethQualityTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var intQuality: UILabel!
    @IBOutlet weak var stringQuatity: UILabel!
    
    @IBOutlet weak var pm10Label: UILabel!
    @IBOutlet weak var pm25Label: UILabel!
    @IBOutlet weak var so2Label: UILabel!
    @IBOutlet weak var coLabel: UILabel!
    @IBOutlet weak var o3Label: UILabel!
    @IBOutlet weak var no2Label: UILabel!
    
    
    @IBOutlet weak var pm25: UILabel!
    @IBOutlet weak var no2: UILabel!
    @IBOutlet weak var co: UILabel!
    @IBOutlet weak var o3: UILabel!
    @IBOutlet weak var so2: UILabel!
    @IBOutlet weak var pm10: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        title.text = "INDEX AQI"
        intQuality.text = "16"
        stringQuatity.text = "fine"
        
        pm10Label.attributedText = exponentiation(string: "PM10", location: 2, length: 2)
        pm25Label.attributedText =  exponentiation(string: "PM2.5", location: 2, length: 3)
        no2Label.attributedText = exponentiation(string: "NO2", location: 2, length: 1)
        coLabel.font = UIFont(name: "Helvetica", size: 17)
        coLabel.text = "CO"
        so2Label.attributedText = exponentiation(string: "SO2", location: 2, length: 1)
        o3Label.attributedText = exponentiation(string: "O3", location: 1, length: 1)
        
//        interface
        intQuality.text = "58"
        intQuality.textColor = .systemGreen
        stringQuatity.text = "Moderate air quality"
        
        pm10.text =  "80"
        pm10.textColor = .systemGreen
        
        pm25.text = "76"
        pm25.textColor = .systemGreen
        
        o3.text = "58"
        o3.textColor = .systemYellow
        
        no2.text = "84"
        no2.textColor = .systemGreen
        
        so2.text = "100"
        so2.textColor = .systemGreen
        
        co.text = "99"
        co.textColor = .systemGreen
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func exponentiation(string: String?,location: Int?, length: Int? ) -> NSMutableAttributedString {
        if let string = string, let location = location, let length = length {
            let font:UIFont? = UIFont(name: "Helvetica", size:17)
            let fontSuper:UIFont? = UIFont(name: "Helvetica", size:12)
            let attString:NSMutableAttributedString = NSMutableAttributedString(string: string, attributes: [.font:font!])
            attString.setAttributes([.font:fontSuper!,.baselineOffset:-5], range: NSRange(location:location,length:length))
            return attString
        }
        return NSMutableAttributedString()
    }
    
}
