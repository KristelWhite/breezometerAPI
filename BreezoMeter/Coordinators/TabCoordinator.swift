//
//  TabCoordinator.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 18.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation
import UIKit

final class TabCoordinator: NSObject, UITabBarControllerDelegate {
    
var rootViewController:  UIViewController{
    return tabController
}
let navigationViewController : UINavigationController
let tabController: UITabBarController
var controllers: [UIViewController] = []

    init(navigationController : UINavigationController) {

    tabController = UITabBarController()
    navigationViewController = navigationController
    
    let brethQualityViewController = BrethQualityViewController()
    brethQualityViewController.tabBarItem = UITabBarItem(title: "Качество воздуха", image: UIImage(imageLiteralResourceName: "weather30"), selectedImage: UIImage(imageLiteralResourceName: "weather30"))

    let pollenViewController = PollenViewController()
    pollenViewController.tabBarItem = UITabBarItem(title: "Пыльца", image: UIImage(imageLiteralResourceName: "pollen30"), selectedImage: UIImage(imageLiteralResourceName: "pollen30"))

    let cardViewController = CardViewController()
    cardViewController.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(imageLiteralResourceName: "map24") , selectedImage: UIImage(systemName: "map24"))

    super.init()

    controllers.append(brethQualityViewController)
    controllers.append(pollenViewController)
    controllers.append(cardViewController)

    tabController.viewControllers = controllers
    tabController.tabBar.isTranslucent = false
    tabController.delegate = self
        
        navigationViewController.pushViewController(tabController, animated: true)
}
}
