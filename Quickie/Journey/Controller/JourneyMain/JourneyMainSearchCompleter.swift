//
//  JourneyMainSearchCompleter.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 06/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import CoreLocation
import MapKit

extension JourneyMainScreenVC: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        tableView.reloadData()
    }
}


