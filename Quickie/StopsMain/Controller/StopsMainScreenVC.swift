//
//  SecondViewController.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 15/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class StopsMainScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorCollection.backgroundColor
        setupNavigationControllerApperance()
    }

    func setupNavigationControllerApperance() {
        navigationItem.title = "Stops"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = ColorCollection.mainColor
    }

}

