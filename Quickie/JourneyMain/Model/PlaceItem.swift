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
    let name: String
    let detailedName: String?
    let coordinate: CLLocationCoordinate2D?
}
