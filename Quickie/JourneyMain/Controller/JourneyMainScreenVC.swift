//
//  FirstViewController.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 15/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class JourneyMainScreenVC: UIViewController, CLLocationManagerDelegate {
    
    // MARK: ------------- PROPERTIES
    
    var activeSearchTextField: UITextField?
    let locationManager = CLLocationManager()
    var departure: PlaceItem?
    var destination: PlaceItem?
    
    let searchBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        return bar
    }()
    
    lazy var departureTextField: SearchTextField = {
        let departure = SearchTextField()
        departure.placeholder = "Departure"
        departure.text = self.departure?.name
        departure.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        departure.mapButton.addTarget(self, action: #selector(presentMapSearchVC(sender:)), for: .touchUpInside)
        return departure
    }()
    
    let destinationTextField: SearchTextField = {
        let destination = SearchTextField()
        destination.placeholder = "Destination"
        destination.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        destination.mapButton.addTarget(self, action: #selector(presentMapSearchVC(sender:)), for: .touchUpInside)
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
    
    var searchCompleter = MKLocalSearchCompleter()
    
    // MARK: ------------- LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerApperance()
        setupViews()
        setupTableView()
        setupMKLocalSearchCompleter()
        setupTextFields()
        checkLocationServices()
        setCurrentLocation()
    }
    
    // MARK: ------------- ACTIONS
    
    func setCurrentLocation() {
        guard let currentLocation = locationManager.location?.coordinate else {
            presentLocationError()
            return }
        
        let departure = PlaceItem(name: "Current Location", detailedName: "", coordinate: currentLocation)
        self.departure = departure
    }
    
    @objc func presentMapSearchVC(sender: UIButton) {
        
        if let superview = sender.superview as? SearchTextField {
            let controllerToPresent = MapSearchVC()
            controllerToPresent.selectionDelegate = self
            controllerToPresent.searchTextField.placeholder = superview.placeholder
            controllerToPresent.title = superview.placeholder
            
            if superview.placeholder == "Departure" {
                controllerToPresent.textFieldType = TextFieldType.departure
            } else {
                controllerToPresent.textFieldType = TextFieldType.destination
            }
            
            navigationController?.pushViewController(controllerToPresent, animated: true)
        }
    }
    
    func updateTableViewResultsFrom(_ textField: UITextField) {
        if let text = textField.text, text != "" {
            searchCompleter.queryFragment = text
            print(searchCompleter.results)
            print("RESULTS COUNT: \(searchCompleter.results.count)")
        } else {
            tableView.reloadData()
        }
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
    
    func setupMKLocalSearchCompleter() {
        searchCompleter.delegate = self
        
        let location = locationManager.location
        searchCompleter.region = MKCoordinateRegion.init(center: (location?.coordinate) ?? LocationDatabase.londonLocation , latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
    func setupTextFields() {
        destinationTextField.delegate = self
        departureTextField.delegate = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressCell.self, forCellReuseIdentifier: CellIDs.addressCellID)
        tableView.register(CurrentLocationCell.self, forCellReuseIdentifier: CellIDs.locationCellID)
        tableView.register(AddressCell.self, forCellReuseIdentifier: CellIDs.favouritesCellID)
    }
    
    func setupViews() {
        
        view.backgroundColor = ColorCollection.backgroundColor
        
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
    
    func presentLocationError() {
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alertController = UIAlertController(title: "Location Services",
                                                message: "Couldn't read your location. Check if location services are turned on in Settings",
                                                preferredStyle: .alert)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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

// MARK: ----------------- TEXT FIELD DELEGATE

extension JourneyMainScreenVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeSearchTextField = textField
        activeSearchTextField?.text = ""
        updateTableViewResultsFrom(textField)
    }
        
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateTableViewResultsFrom(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeSearchTextField = nil
        tableView.reloadData()
    }

}

enum TextFieldType {
    case destination
    case departure
}
