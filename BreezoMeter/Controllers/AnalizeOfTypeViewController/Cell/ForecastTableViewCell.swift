//
//  ForecastTableViewCell.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 28.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TodayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "todayViewCell")
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ForecastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayViewCell", for: indexPath) as! TodayCollectionViewCell
               
               if indexPath.row == 0 {
                   cell.weekday.text = "Today"
               }
               else if indexPath.row == 1 {
                   cell.weekday.text = "Tomorrow"
               }
               else if indexPath.row == 2 {
                   cell.weekday.text = "After tomorrow"
               }
               return cell
    }
    
    
}
extension ForecastTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWight = (Double(collectionView.bounds.width) - Double(2) * 10) / Double(3)
        let cellHeight = (Double(collectionView.bounds.height) - Double(2) * 10 - 10 * 2)
        return CGSize(width: cellWight, height: cellHeight)
    }
}
