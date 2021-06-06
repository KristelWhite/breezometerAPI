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

class BrethQualityViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var seachBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    override func viewDidLoad() {
        super.viewDidLoad()
        seachBar.delegate = self
        tableView.delegate = self
        tableView.rowHeight = 200
        tableView.register(UINib(nibName: "BrethQualityTableViewCell", bundle: nil),
        forCellReuseIdentifier: "brethQualityViewCell")
        
        
        
        let viewModel = AirQualityModelView(tabelView: tableView, API: APIProvider())

        
        
        viewModel.modelObservable.asObservable().bind(to: tableView.rx.items){(tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "brethQualityViewCell") as! BrethQualityTableViewCell
            guard element.data?.dataAvailable == true else {
            return UITableViewCell()
            }
            if let aqi = element.data?.indexes?.baqi?.aqiDisplay {
                cell.intQuality?.text = aqi
                let numAqi = element.data?.indexes?.baqi?.aqi!
                if numAqi! < 30 {
                    cell.stringQuatity.text = "Very Bad"
                }
                else if numAqi! < 50 {
                    cell.stringQuatity.text = "Bad"
                }
                else if numAqi! < 75 {
                    cell.stringQuatity.text = "Good"
                }
                else {
                    cell.stringQuatity.text = "Exelent"
                }
            }
            if let co = element.data?.pollutants?.co?.aqiInformation?.baqi?.aqiDisplay {
                cell.co.text = co
            }
            if let no2 = element.data?.pollutants?.no2?.aqiInformation?.baqi?.aqiDisplay {
                cell.no2.text = no2
            }
            if let o3 = element.data?.pollutants?.o3?.aqiInformation?.baqi?.aqiDisplay {
                cell.o3.text = o3
            }
            if let pm10 = element.data?.pollutants?.pm10?.aqiInformation?.baqi?.aqiDisplay {
                cell.pm10.text = pm10
            }
            if let pm25 = element.data?.pollutants?.pm25?.aqiInformation?.baqi?.aqiDisplay {
                cell.pm25.text = pm25
            }
            if let so2 = element.data?.pollutants?.so2?.aqiInformation?.baqi?.aqiDisplay {
                cell.so2.text = so2
            }
            return cell
        }.disposed(by: disposeBag)
        
        viewModel.geolocation.asObservable().distinctUntilChanged{ $0 == $1 }.subscribe(onNext: {
            lat, long in
            self.seachBar.text = "\(lat), \(long)"
            }).disposed(by: disposeBag)
        
        seachBar.rx.text.asObservable().observe(on: concurrentScheduler).distinctUntilChanged{ $0 ==  $1 }.subscribe(on: MainScheduler()).subscribe(onNext: {
            text in
            viewModel.place.onNext(text!)
        }
        ).disposed(by: disposeBag)
        
//        seachBar.rx.searchButtonClicked.map(<#T##transform: (()) throws -> Result##(()) throws -> Result#>)
        // не работает!!!
        seachBar.rx.cancelButtonClicked
        .asDriver()
        .drive(onNext: { [weak seachBar] in
            seachBar?.searchTextField.text = "elfkbkb"
            viewModel.place.onNext(seachBar?.text ?? "")
            print("cansel button")
            
            
        }).disposed(by: disposeBag)
        
    }

}

extension BrethQualityViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
             
            let cell = tableView.dequeueReusableCell(withIdentifier: "brethQualityViewCell", for: indexPath) as! BrethQualityTableViewCell
             return cell
            
         }
        return UITableViewCell()
    }
    
    
}

