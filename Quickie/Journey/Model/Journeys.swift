//
//  Journeys.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 20/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

struct Journeys: Codable {
    var journeys: [Journey]
}

struct Journey: Codable {
    var startDateTime: String
    var arrivalDateTime: String
    var duration: Int
    var legs: [Leg]
    var fare: Fare
}

struct Leg: Codable {
    var mode: Mode
    var routeOptions: [Route]
}

struct Mode: Codable {
    var name: String
}

struct Route: Codable {
    var name: String
}

struct Fare: Codable {
    var totalCost: Int
}
