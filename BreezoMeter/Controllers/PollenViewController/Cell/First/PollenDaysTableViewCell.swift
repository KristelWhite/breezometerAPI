//
//  PollenDaysTableViewCell.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 19.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class PollenDaysTableViewCell: UITableViewCell{

    @IBOutlet weak var grassButton: UIButton!
    @IBOutlet weak var weedButton: UIButton!
    @IBOutlet weak var treeButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TodayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "todayViewCell")
        
        grassButton.setTitle("Grass", for: .normal)
        grassButton.setImage(UIImage(named: "grass24")!, for: .normal)
        grassButton.imageView?.contentMode = .scaleAspectFit
        grassButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        weedButton.setTitle("Weed", for: .normal)
        weedButton.setImage(UIImage(named: "leaf24")!, for: .normal)
        weedButton.imageView?.contentMode = .scaleAspectFit
        weedButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        treeButton.setTitle("Trees", for: .normal)
        treeButton.setImage(UIImage(named: "tree24")!, for: .normal)
        treeButton.imageView?.contentMode = .scaleAspectFit
        treeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
    }
        
         

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PollenDaysTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource  {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath) as? TodayCollectionViewCell
        //SHADOW :
        
//        let color: UIColor = .black
//        cell?.layer.shadowRadius = 2
//        cell?.layer.shadowColor = color.cgColor
//        cell?.layer.shadowOpacity = 20
//        cell?.layer.shadowOffset = CGSize(width: 5, height: 5)
//        cell?.layer.masksToBounds = false
        cell?.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        cell?.layer.borderWidth = 3
//        cell?.layer.shadowColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TodayCollectionViewCell
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.layer.borderWidth = 3
    }
    
    
}

extension PollenDaysTableViewCell: UICollectionViewDelegateFlowLayout {
    
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

