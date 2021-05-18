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
let tabController: UITabBarController
var controllers: [UIViewController] = []

override init() {

    tabController = UITabBarController()
    
 
    let brethQualityViewController = BrethQualityViewController()
    brethQualityViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))

    let pollenViewController = PollenViewController()
    pollenViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))

    let cardViewController = CardViewController()
    cardViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))

    super.init()

    controllers.append(brethQualityViewController)
    controllers.append(pollenViewController)
    controllers.append(cardViewController)

    tabController.viewControllers = controllers
    tabController.tabBar.isTranslucent = false
    tabController.delegate = self

}
}
