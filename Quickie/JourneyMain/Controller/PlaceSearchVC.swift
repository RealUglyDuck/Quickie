//
//  PlaceSearchVC.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 25/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PlaceSearchVC: UIViewController, UITextFieldDelegate {

    // MARK: ---------- PROPERTIES
    
    let searchBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        return bar
    }()
    
    let searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = "Departure"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    let tableView: UITableView  = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var searchCompleter = MKLocalSearchCompleter()
    var locationManager = CLLocationManager()
    var selectionDelegate: PlaceSelectionDelegate!
    var textFieldType: TextFieldType = .destination
    
    // MARK: ---------- LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorCollection.backgroundColor
        setupViews()
        setupTableView()
        setupMKLocalSearchCompleter()
        searchTextField.becomeFirstResponder()
    }
    
    // MARK: ---------- TEXTFIELD
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            searchCompleter.queryFragment = text
            print(searchCompleter.results)
            print("RESULTS COUNT: \(searchCompleter.results.count)")
        }
    }
    
    // MARK: ---------- SETUPS
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressCell.self, forCellReuseIdentifier: CellIDs.locationCellID)
    }
    
    func setupMKLocalSearchCompleter() {
        searchCompleter.delegate = self
        
        let location = locationManager.location
        searchCompleter.region = MKCoordinateRegion.init(center: (location?.coordinate)!, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
    func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        searchBar.addSubview(searchTextField)
        
        searchBar.setSize(width: nil, height: 58)
        searchBar.constraintsTo(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil)
        searchTextField.constraintToSuperViewWith(margin: 9)
        
        _ = tableView.constraintWithDistanceTo(top: searchBar.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topDistance: 10, leftDistance: 15, rightDistance: 15, bottomDistance: 0)
    }
    
}

// MARK: ----------------- SEARCH COMPLETER DELEGATE

extension PlaceSearchVC: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        tableView.reloadData()
    }
}

// MARK: ------------ PROTOCOLS

protocol PlaceSelectionDelegate {
    func didSelectPlace(place: PlaceItem, textFieldType: TextFieldType)
}
