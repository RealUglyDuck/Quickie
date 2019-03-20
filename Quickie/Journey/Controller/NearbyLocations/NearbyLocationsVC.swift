//
//  NearbyLocationsVC.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 17/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearbyLocationsVC: UIViewController {

    let mapView = MKMapView()
    var mapItems: [MKMapItem]?
    var querry: String?
    let locationManager = CLLocationManager()
    var textFieldType: SearchTextFieldType?
    var selectionDelegate: PlaceSelectionDelegate!
    
    let searchHereButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search here", for: .normal)
        button.backgroundColor = ColorCollection.mainColor
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(querry!.capitalized) nearby"
        setupViews()
        centerToUserLocation()
        performSearch()
        
        mapView.delegate = self
        searchHereButton.isHidden = true
    }
    
    func centerToUserLocation() {
        guard let location = locationManager.location else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.region = region
    }
    
    func updateMap() {
        mapView.removeAnnotations(mapView.annotations)
        guard let mapItems = mapItems else { return }
        for item in mapItems {
            
            let annotation = PlaceItem(name: item.name ?? "", detailedName: item.placemark.title ?? "", coordinate: item.placemark.coordinate)
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc func performSearch() {
        
        let request = MKLocalSearch.Request()
        request.region = mapView.region
        print(mapView.region)
        request.naturalLanguageQuery = querry
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            guard let response = response else {
                print(error?.localizedDescription ?? "Error")
                return
                
            }
            self.mapItems = response.mapItems
            self.updateMap()
        }
        
        searchHereButton.isHidden = true
    }
    
    func setupViews() {
        view.addSubview(mapView)
        view.addSubview(searchHereButton)
        mapView.constraintToSuperView()
        mapView.showsUserLocation = true
        searchHereButton.setSize(width: 150, height: 40)
        searchHereButton.centerInTheView(centerX: view.centerXAnchor, centerY: nil)
        searchHereButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 30).isActive = true
    }
}

extension NearbyLocationsVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        let button = UIButton()
        button.setImage(UIImage(named: ImageDatabase.confirmIcon), for: .normal)
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "id")
        annotationView.markerTintColor = ColorCollection.mainColor
        annotationView.canShowCallout = true
        
        let rightButton = UIButton()
        let image = UIImage(named: ImageDatabase.confirmIcon)
        
        rightButton.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        rightButton.setBackgroundImage(image, for: .normal)
        
        annotationView.rightCalloutAccessoryView = rightButton
        annotationView.titleVisibility = .adaptive
        annotationView.subtitleVisibility = .hidden
        
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        searchHereButton.isHidden = false
        print("region did change animated")
//        performSearch()
        print(mapView.region)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        let title = annotation.title
        let subtitle = annotation.subtitle
        let coordinate = annotation.coordinate
        
        let place = PlaceItem(name: title as! String, detailedName: subtitle as! String, coordinate: coordinate)
        
        selectionDelegate.didSelectPlace(place: place, textFieldType: textFieldType!)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
