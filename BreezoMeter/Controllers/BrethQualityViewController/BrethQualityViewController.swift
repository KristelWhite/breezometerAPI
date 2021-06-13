//
//  BrethQualityViewController.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 19.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BrethQualityViewController: UIViewController,  UISearchBarDelegate {
    
    @IBOutlet weak var seachBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : AirQualityViewModel? = nil
    
    var disposeBag = DisposeBag()
    
    let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seachBar.delegate = self
        tableView.delegate = self
        tableView.rowHeight = 200
        tableView.register(UINib(nibName: "BrethQualityTableViewCell", bundle: nil),
        forCellReuseIdentifier: "brethQualityViewCell")
        
        
        
        
        
        viewModel = AirQualityViewModel(tabelView: tableView, API: APIProvider())

        
//        байндим данные из модели в таблицу
        viewModel?.modelObservable.bind(to: tableView.rx.items){(tableView, row, element) in
            guard element.error == nil else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "no data"
                cell.textLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
                cell.textLabel?.textColor = .systemGray
            return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "brethQualityViewCell") as! BrethQualityTableViewCell
         
            if let aqi = element.data?.indexes?.baqi?.aqiDisplay {
                cell.intQuality?.text = aqi
                self.aqiTextColor(label: cell.intQuality, qualityLable: cell.stringQuatity)
            }
            if let co = element.data?.pollutants?.co?.aqiInformation?.baqi?.aqiDisplay {
                cell.co.text = co
                self.aqiTextColor(label: cell.co, qualityLable: nil)
            }
            if let no2 = element.data?.pollutants?.no2?.aqiInformation?.baqi?.aqiDisplay {
                cell.no2.text = no2
                self.aqiTextColor(label: cell.no2, qualityLable: nil)
            }
            if let o3 = element.data?.pollutants?.o3?.aqiInformation?.baqi?.aqiDisplay {
                cell.o3.text = o3
                self.aqiTextColor(label: cell.o3, qualityLable: nil)
            }
            if let pm10 = element.data?.pollutants?.pm10?.aqiInformation?.baqi?.aqiDisplay {
                cell.pm10.text = pm10
                self.aqiTextColor(label: cell.pm10, qualityLable: nil)
            }
            if let pm25 = element.data?.pollutants?.pm25?.aqiInformation?.baqi?.aqiDisplay {
                cell.pm25.text = pm25
                self.aqiTextColor(label: cell.pm25, qualityLable: nil)
            }
            if let so2 = element.data?.pollutants?.so2?.aqiInformation?.baqi?.aqiDisplay {
                cell.so2.text = so2
                self.aqiTextColor(label: cell.so2, qualityLable: nil)
            }
            return cell
        }.disposed(by: disposeBag)

// если поменялась геолокация выводим координаты на панель поиска
        viewModel?.geolocation.distinctUntilChanged{ $0 == $1 }.subscribe(onNext: {
            lat, long in
            self.seachBar.text = "\(lat), \(long)"
            }).disposed(by: disposeBag)

//        seachBar.rx.text.asObservable().observe(on: concurrentScheduler).distinctUntilChanged{ $0 ==  $1 }.subscribe(on: MainScheduler()).subscribe(onNext: {
//            text in
//            self.viewModel?.place.onNext(text!)
//        }
//        ).disposed(by: disposeBag)
        
//связываем нажатие кнопки поиска с изменением place в modelView
        
        seachBar.rx.searchButtonClicked.subscribe({
            event in
            self.viewModel?.place.onNext(self.seachBar?.text ?? "")
            }).disposed(by: disposeBag)
//        seachBar.text = ("Berlin, Germani")
        
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

extension BrethQualityViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
}

