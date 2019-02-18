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
        
        let journeyMainScreenVC = UINavigationController(rootViewController: JourneyMainScreenVC())
        let stopsMainScreenVC = UINavigationController(rootViewController: StopsMainScreenVC())
        let settingsVC = UINavigationController(rootViewController: SettingsVC())
        
        journeyMainScreenVC.tabBarItem  = UITabBarItem(title: "Journey",
                                                       image: UIImage(named: ImageDatabase.mapMarkerIconActive),
                                                       tag: 0)
        
        stopsMainScreenVC.tabBarItem    = UITabBarItem(title: "Buses",
                                                       image: UIImage(named: ImageDatabase.busIcon),
                                                       tag: 1)
        
        settingsVC.tabBarItem           = UITabBarItem(title: "Settings",
                                                       image: UIImage(named: ImageDatabase.settingsIcon),
                                                       tag: 2)
        
        self.tabBar.tintColor = ColorCollection.mainColor
        viewControllers = [journeyMainScreenVC,stopsMainScreenVC,settingsVC]
        
    }

}
