//
//  FirstViewController.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 15/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import CoreLocation

class JourneyMainScreenVC: UIViewController, CLLocationManagerDelegate {
    
    // MARK: ------------- PROPERTIES
    
    let locationManager = CLLocationManager()
    
    let searchBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        return bar
    }()
    
    let departureTextField: SearchTextField = {
        let departure = SearchTextField()
        departure.placeholder = "Departure"
        departure.addTarget(self, action: #selector(presentPlaceSearchVC), for: .touchDown)
        return departure
    }()
    
    let destinationTextField: SearchTextField = {
        let destination = SearchTextField()
        destination.placeholder = "Destination"
        destination.addTarget(self, action: #selector(presentPlaceSearchVC), for: .touchDown)
        return destination
    }()
    
    let journeyImage: UIImageView = {
        let image = UIImage(named: ImageDatabase.departureDestinationIcon)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: ------------- LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerApperance()
        setupViews()
        setupTableView()
        view.backgroundColor = ColorCollection.backgroundColor
        checkLocationServices()
    }
    
    // MARK: ------------- ACTIONS
    
    @objc func presentPlaceSearchVC(sender: SearchTextField) {
        
        let controllerToPresent = PlaceSearchVC()
        controllerToPresent.selectionDelegate = self
        controllerToPresent.searchTextField.placeholder = sender.placeholder
        controllerToPresent.title = sender.placeholder
        
        if sender.placeholder == "Departure" {
            controllerToPresent.textFieldType = TextFieldType.departure
        } else {
            controllerToPresent.textFieldType = TextFieldType.destination
        }
        
        navigationController?.pushViewController(controllerToPresent, animated: true)
    }
    
    // MARK: ------------- SETUPS
    
    func setupNavigationControllerApperance() {
        navigationItem.title = "Journey Planner"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = ColorCollection.mainColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressCell.self, forCellReuseIdentifier: CellIDs.addressCellID)
        tableView.register(CurrentLocationCell.self, forCellReuseIdentifier: CellIDs.locationCellID)
    }
    
    func setupViews() {
        view.addSubview(searchBar)
        searchBar.addSubview(departureTextField)
        searchBar.addSubview(destinationTextField)
        searchBar.addSubview(journeyImage)
        view.addSubview(tableView)
        
        _ = searchBar.constraintAnchors(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, topDistance: 0, leftDistance: 0, rightDistance: 0, bottomDistance: 0, height: 108, width: nil)
        
        _ = journeyImage.constraintWithDistanceTo(top: departureTextField.centerYAnchor , leading: searchBar.leadingAnchor, trailing: departureTextField.leadingAnchor, bottom: searchBar.bottomAnchor, topDistance: -5, leftDistance: 0, rightDistance: 0, bottomDistance: 21)
        
        _ = departureTextField.constraintWithDistanceTo(top: searchBar.topAnchor, leading: searchBar.leadingAnchor, trailing: searchBar.trailingAnchor, bottom: nil, topDistance: 9, leftDistance: 30, rightDistance: 9, bottomDistance: 0)
        
        departureTextField.setSize(width: nil, height: 40)
        
        _ = destinationTextField.constraintAnchors(top: nil, leading: searchBar.leadingAnchor, trailing: searchBar.trailingAnchor, bottom: searchBar.bottomAnchor, topDistance: 0, leftDistance: 30, rightDistance: 9, bottomDistance: 9, height: 40, width: nil)
        
        _ = tableView.constraintWithDistanceTo(top: searchBar.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topDistance: 10, leftDistance: 15, rightDistance: 15, bottomDistance: 0)
    }
    
    // MARK: ------------- LOCATION SERVICES
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("access granted")
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            print("requested")
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

extension JourneyMainScreenVC: PlaceSelectionDelegate {
    func didSelectPlace(place: PlaceItem, textFieldType: TextFieldType) {
        if textFieldType == .departure {
            departureTextField.text = place.name
        } else {
            destinationTextField.text = place.name
        }
    }
}

enum TextFieldType {
    case destination
    case departure
}
