//
//  AnalizeOfTypeViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 25.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit

class AnalizeOfTypeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil),
        forCellReuseIdentifier: "forecastCell")
        tableView.rowHeight = 200
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
extension AnalizeOfTypeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Forecast"
            cell.textLabel?.textColor = .green
            return cell
        }
        else if indexPath.row == 1 {
            return UITableViewCell()
        }
        return UITableViewCell()
        
    }
    
    
}
