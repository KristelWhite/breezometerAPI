//
//  PollenViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 19.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class PollenViewController: UIViewController {

    @IBOutlet weak var seachBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PollenDaysTableViewCell", bundle: nil),
        forCellReuseIdentifier: "daysViewCell")
        tableView.register(UINib(nibName: "ListOfPollenTypesTableViewCell", bundle: nil),
           forCellReuseIdentifier: "typesViewCell")
        seachBar.text = ("Berlin, Germani")
                          
        
        
       
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

extension PollenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.rowHeight = 230
            let cell = tableView.dequeueReusableCell(withIdentifier: "daysViewCell", for: indexPath) as! PollenDaysTableViewCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "typesViewCell", for: indexPath) as!   ListOfPollenTypesTableViewCell
            return cell
        }
       return UITableViewCell()
    }
    
    
}
