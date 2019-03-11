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

public struct PlaceItem {
    let name: String?
    let detailedName: String?
    let latitude: Double?
    let longitude: Double?
    
    init(name: String, detailedName: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.detailedName = detailedName
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    init(searchCompletion: MKLocalSearchCompletion, placemark: MKPlacemark) {
        self.name = searchCompletion.title
        self.detailedName = searchCompletion.subtitle
        self.latitude = placemark.coordinate.latitude
        self.longitude = placemark.coordinate.longitude
    }
}
