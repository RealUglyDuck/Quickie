//
//  FirstViewController.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 15/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class JourneyMainScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationControllerApperance()
        view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupNavigationControllerApperance() {
        navigationItem.title = "Journey Planner"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = ColorCollection.mainColor
    }


}

