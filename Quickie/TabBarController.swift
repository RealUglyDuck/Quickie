//
//  TabBarControllerViewController.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 15/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let journeyMainScreenVC = JourneyMainScreenVC()
        let stopsMainScreenVC = StopsMainScreenVC()
        let settingsVC = SettingsVC()
        journeyMainScreenVC.tabBarItem = UITabBarItem(title: "Journey", image: nil, tag: 0)
        stopsMainScreenVC.tabBarItem = UITabBarItem(title: "Buses", image: nil, tag: 1)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 2)
        
        viewControllers = [journeyMainScreenVC,stopsMainScreenVC,settingsVC]
    }

}
