//
//  BrethQualityViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 19.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class BrethQualityViewController: UIViewController {
    
    @IBOutlet weak var seachBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BrethQualityTableViewCell", bundle: nil),
        forCellReuseIdentifier: "brethQualityViewCell")
        tableView.register(UINib(nibName: "ImpuritiesTableViewCell", bundle: nil),
        forCellReuseIdentifier: "impuritiesViewCell")
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

extension BrethQualityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
             tableView.rowHeight = 200
            let cell = tableView.dequeueReusableCell(withIdentifier: "brethQualityViewCell", for: indexPath) as! BrethQualityTableViewCell
             return cell
            
         }
         else if indexPath.row == 1 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "impuritiesViewCell", for: indexPath) as! ImpuritiesTableViewCell
             return cell
         }
        return UITableViewCell()
    }
    
    
}

