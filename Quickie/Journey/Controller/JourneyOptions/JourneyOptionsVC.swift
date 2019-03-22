//
//  JourneyOptionsVC.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 09/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class JourneyOptionsVC: UIViewController {

    let departure: PlaceItem?
    let destination: PlaceItem?
    var attributedString = NSMutableAttributedString()
    var journeysDataManager: JourneysDataManager?
    
    let searchBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        return bar
    }()
    
    lazy var departureTextField: SearchTextField = {
        let departure = SearchTextField(type: .departure)
        departure.placeholder = "Departure"
        departure.text = self.departure?.title
        departure.isEnabled = false
        return departure
    }()
    
    lazy var destinationTextField: SearchTextField = {
        let destination = SearchTextField(type: .destination)
        destination.text = self.destination?.title
        destination.isEnabled = false
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
    
    init(departure: PlaceItem, destination: PlaceItem) {
        self.departure = departure
        self.destination = destination
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
        setupTableView()
        setupViews()
        updateTextFields()
        setupNavigationControllerApperance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTextFields() {
        departureTextField.text = self.departure?.title
        destinationTextField.text = self.destination?.title
    }
    
    func setupNavigationControllerApperance() {
        navigationItem.title = "Journey Options" 
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JourneyOptionCell.self, forCellReuseIdentifier: CellIDs.journeyOptionCellID)
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
    
    func fetchJSON() {
        
        let destinationCoordinates = "\(destination!.coordinate.latitude)%2C\(destination!.coordinate.longitude)"
        let departureCoordinates = "\(departure!.coordinate.latitude)%2C\(departure!.coordinate.longitude)"
        
        
        let urlString = "https://api.tfl.gov.uk/Journey/JourneyResults/\(departureCoordinates)/to/\(destinationCoordinates)?mode=bus%2Ctube&app_id=e171df45&app_key=bb0047f1885b728ca89b5274dee61460"
        guard let url = URL(string: urlString) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("error reading data \(error)")
                    return
                }
                
                guard let data = data else { return }
                var journeys: JourneysData?
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    journeys = try decoder.decode(JourneysData.self, from: data)
                    print(journeys ?? "")
                    guard let journeys = journeys else { return }
                    self.journeysDataManager = JourneysDataManager(journeysData: journeys)
                    self.tableView.reloadData()
                    
                } catch let jsonError {
                    print("Failed to decode: \(jsonError)")
                }
            }
            }.resume()
        print("completion not run")
    }

}
