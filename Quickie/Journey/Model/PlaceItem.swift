//
//  Place.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 28/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class PlaceItem: NSObject, MKAnnotation {
    let latitude: Double
    let longitude: Double
    let title: String?
    let subtitle: String?
    
    init(name: String, detailedName: String, coordinate: CLLocationCoordinate2D) {
        self.title = name
        self.subtitle = detailedName
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        super.init()
    }
    
    init(searchCompletion: MKLocalSearchCompletion, placemark: MKPlacemark) {
        self.title = searchCompletion.title
        self.subtitle = searchCompletion.subtitle
        self.latitude = placemark.coordinate.latitude
        self.longitude = placemark.coordinate.longitude
        super.init()
    }
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name
        self.subtitle = mapItem.placemark.title
        self.latitude = mapItem.placemark.coordinate.latitude
        self.longitude = mapItem.placemark.coordinate.longitude
        
        super.init()
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
