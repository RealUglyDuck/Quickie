//
//  FirstViewController.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 15/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class JourneyMainScreenVC: UIViewController {

    let searchBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        return bar
    }()
    
    let departureTextField: SearchTextField = {
        let departure = SearchTextField()
        departure.placeholder = "Departure"
        return departure
    }()
    
    let destinationTextField: SearchTextField = {
        let destination = SearchTextField()
        destination.placeholder = "Destination"
        return destination
    }()
    
    let journeyImage: UIImageView = {
        let image = UIImage(named: ImageDatabase.departureDestinationIcon)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
//    let tableView: UITableView = {
//        let tableView = UITableView()
//
//        return tableView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerApperance()
        setupViews()
        view.backgroundColor = ColorCollection.backgroundColor
        
    }
    
    func setupNavigationControllerApperance() {
        navigationItem.title = "Journey Planner"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = ColorCollection.mainColor
    }
    
    func setupViews() {
        view.addSubview(searchBar)
        searchBar.addSubview(departureTextField)
        searchBar.addSubview(destinationTextField)
        searchBar.addSubview(journeyImage)
        
        _ = searchBar.constraintAnchors(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, topDistance: 0, leftDistance: 0, rightDistance: 0, bottomDistance: 0, height: 108, width: nil)
        
        _ = journeyImage.constraintWithDistanceTo(top: departureTextField.centerYAnchor , leading: searchBar.leadingAnchor, trailing: departureTextField.leadingAnchor, bottom: searchBar.bottomAnchor, topDistance: -5, leftDistance: 0, rightDistance: 0, bottomDistance: 21)
        
        _ = departureTextField.constraintWithDistanceTo(top: searchBar.topAnchor, leading: searchBar.leadingAnchor, trailing: searchBar.trailingAnchor, bottom: nil, topDistance: 9, leftDistance: 30, rightDistance: 9, bottomDistance: 0)
        
        departureTextField.setSize(width: nil, height: 40)
        
        _ = destinationTextField.constraintAnchors(top: nil, leading: searchBar.leadingAnchor, trailing: searchBar.trailingAnchor, bottom: searchBar.bottomAnchor, topDistance: 0, leftDistance: 30, rightDistance: 9, bottomDistance: 9, height: 40, width: nil)
    }

}

