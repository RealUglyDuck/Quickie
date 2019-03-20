//
//  NearbyAnnotation.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 17/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import MapKit

class NearbyAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
