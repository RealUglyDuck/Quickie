//
//  MapSearchVC
//  Quickie
//
//  Created by Paweł Ambrożej on 25/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapSearchVC: UIViewController {
    
    // MARK: ---------- PROPERTIES
    
    let searchBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        return bar
    }()
    
    let searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = "Departure"
        let image = UIImage(named: ImageDatabase.confirmIcon)
        textField.mapButton.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        textField.mapButton.imageView?.contentMode = .scaleAspectFit
        textField.mapButton.setBackgroundImage(image, for: .normal)
        textField.mapButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchDown)
        return textField
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        let currentLocation = locationManager.location?.coordinate
        let image = UIImage(named: ImageDatabase.mapPinIcon)
        let mapPinIcon = UIImageView(image: image)
        
        mapView.region = MKCoordinateRegion(center: currentLocation ?? LocationDatabase.londonLocation, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.addSubview(mapPinIcon)
        mapPinIcon.centerInTheView(centerX: mapView.centerXAnchor, centerY: nil)
        mapPinIcon.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -mapPinIcon.bounds.height/2).isActive = true
        
        return mapView
    }()
    

    var locationManager = CLLocationManager()
    var selectionDelegate: PlaceSelectionDelegate!
    var textFieldType: TextFieldType = .destination
    var previousLocation: CLLocation?
    let searchCompleter = MKLocalSearchCompleter()
    
    
    
    
    // MARK: ---------- LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorCollection.backgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Map Search", style: .plain, target: nil, action: nil)
        setupViews()
        mapView.delegate = self
        previousLocation = getCenterLocation(for: mapView)
        
    }
    
    // MARK: ---------- TEXTFIELD
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @objc func confirmButtonPressed() {
        
        print(searchCompleter.results)
        
        let request = MKLocalSearch.Request(completion: searchCompleter.results[0])
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            
            guard let response = response else { return }
            
            let location = response.mapItems[0].placemark
            print(location.coordinate)
            let title = self.searchCompleter.results[0].title
            let subtitle = self.searchCompleter.results[0].subtitle
            let place = PlaceItem(name: title, detailedName: subtitle, coordinate: location.coordinate)
            
            self.selectionDelegate.didSelectPlace(place: place, textFieldType: self.textFieldType)
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    // MARK: ---------- SETUPS

    func setupSearchCompleter() {
        let location = locationManager.location
        searchCompleter.region = MKCoordinateRegion.init(center: (location?.coordinate)!, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
    func setupViews() {
        view.addSubview(searchBar)
        searchBar.addSubview(searchTextField)
        view.addSubview(mapView)
        
        searchBar.setSize(width: nil, height: 58)
        searchBar.constraintsTo(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil)

        searchTextField.constraintToSuperViewWith(margin: 9)
        
        mapView.constraintsTo(top: searchBar.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
    }
    
}

// MARK: ------------ MAP DELEGATE

extension MapSearchVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 10 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                return
            }
            
            guard let placemark = placemarks?.first else {
                return
            }
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.searchTextField.text = "\(streetNumber) \(streetName)"
                self.searchCompleter.queryFragment = self.searchTextField.text ?? ""
            }
        }
    }
}

// MARK: ------------ PROTOCOLS

protocol PlaceSelectionDelegate {
    func didSelectPlace(place: PlaceItem, textFieldType: TextFieldType)
}
