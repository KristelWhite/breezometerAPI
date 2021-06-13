//
//  PollenViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 19.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PollenViewController: UIViewController {

    @IBOutlet weak var seachBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : PollenViewModel? = nil
    
    var disposeBag = DisposeBag()
    
    let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "PollenDaysTableViewCell", bundle: nil),
        forCellReuseIdentifier: "daysViewCell")
        tableView.register(UINib(nibName: "ListOfPollenTypesTableViewCell", bundle: nil),
           forCellReuseIdentifier: "typesViewCell")
//        seachBar.text = ("Berlin, Germani")
                          
        viewModel = PollenViewModel(tabelView: tableView, API: APIProvider())

        
//        байндим данные из модели в таблицу
        viewModel?.modelObservable.bind(to: tableView.rx.items){(tableView, row, element) in
            guard element.error == nil else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "no data"
                cell.textLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
                cell.textLabel?.textColor = .systemGray
                return cell
            }
            if row == 0 {
                tableView.rowHeight = 230
                let cell = tableView.dequeueReusableCell(withIdentifier: "daysViewCell") as! PollenDaysTableViewCell
                cell.viewModel = self.viewModel
//                cell.viewModel?.state.onNext(PollenViewModel.State.tree)
                cell.state.onNext(PollenDaysTableViewCell.State.tree)
                return cell
            }
            else if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "typesViewCell") as!   ListOfPollenTypesTableViewCell
                cell.viewModel = self.viewModel 
                return cell
            }
            else {
                return UITableViewCell()
            }
            
            
        }.disposed(by: disposeBag)

// если поменялась геолокация выводим координаты на панель поиска
        viewModel?.geolocation.distinctUntilChanged{ $0 == $1 }.subscribe(onNext: {
            lat, long in
            self.seachBar.text = "\(lat), \(long)"
            }).disposed(by: disposeBag)

        
//связываем нажатие кнопки поиска с изменением place в modelView
        
        seachBar.rx.searchButtonClicked.subscribe({
            event in
            self.viewModel?.place.onNext(self.seachBar?.text ?? "")
            }).disposed(by: disposeBag)
        
    }
    
    func aqiTextColor(label: UILabel, qualityLable: UILabel?){
        if let text = label.text {
            let intLabel: Int? = Int(text)
            if let intLabel = intLabel {
                if intLabel < 30 {
                    qualityLable?.text = "Very Bad"
                    label.textColor = .systemPurple
                }
                else if intLabel < 50 {
                    qualityLable?.text = "Bad"
                    label.textColor = .systemRed
                }
                else if intLabel < 75 {
                    qualityLable?.text = "Good"
                    label.textColor = .systemYellow
                }
                else {
                    qualityLable?.text = "Exelent"
                    label.textColor = .systemGreen
                }
            }
        }
    }
}

extension PollenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    
}
