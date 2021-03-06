//
//  ListOfPollenTypesTableViewCell.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 24.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class ListOfPollenTypesTableViewCell: UITableViewCell {

    @IBOutlet weak var analizeOfTypesLable: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PollenViewModel? = nil 
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self

        analizeOfTypesLable.text = "Analize of types"
        analizeOfTypesLable.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        analizeOfTypesLable.textColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ListOfPollenTypesTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            cell.textLabel?.text = "Pine"
        }
        else {
            
            cell.textLabel?.text = "Olive tree"
        }
        
        
        cell.detailTextLabel?.text = "детали"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}

