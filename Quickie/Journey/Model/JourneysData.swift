//
//  Journeys.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 20/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

struct JourneysData: Decodable {
    var journeys: [Journey]
}

struct Journey: Decodable {
    var startDateTime: Date?
    var arrivalDateTime: Date?
    var duration: Int
    var legs: [Leg]
    var fare: Fare?
}

struct Leg: Decodable {
    var mode: Mode
    var routeOptions: [Route]
}

struct Mode: Decodable {
    var name: TransportTypes
}

struct Route: Decodable {
    var name: String
}

struct Fare: Decodable {
    var totalCost: Int
}
