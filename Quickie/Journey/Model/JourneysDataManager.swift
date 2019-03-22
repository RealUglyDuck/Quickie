//
//  JourneysController.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 20/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import Foundation
import UIKit

class JourneysDataManager: NSObject {
    let journeysData: JourneysData
    
    init(journeysData: JourneysData) {
        self.journeysData = journeysData
    }
    
    func generateDetailsLabelString(for journeyNumber: Int) -> String {
        
//        let startTime = journeysData.journeys[journeyNumber].startDateTime
        let journey = journeysData.journeys[journeyNumber]
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startDate = formatter.string(from: journey.startDateTime ?? Date())
        let arriveDate = formatter.string(from: journey.arrivalDateTime ?? Date())
        print(journey.fare?.totalCost)
        let fareDouble = Double(journey.fare?.totalCost ?? 0)
        let fareString = String(format: "%.2f", fareDouble/100)
        return "\(startDate) - Arrive at \(arriveDate)  £\(fareString)"
    }
    
    
    func generateMainLabelString(for journeyNumber: Int) -> NSMutableAttributedString {
        guard let journey = journeysData.journeys[journeyNumber] as? Journey else { return NSMutableAttributedString()}
        let mutableAttributedString = NSMutableAttributedString()
//
        for index in journey.legs.indices {
            let leg = journey.legs[index]
            var color = UIColor.black
            var text = ""
            if leg.mode.name != .walking {
                for index in leg.routeOptions.indices {
                    let route = leg.routeOptions[index]
                    text = route.name
                    if leg.mode.name == .tube {
                        let tubeLine = TubeLines.init(rawValue: route.name.lowercased())
                        color = getTubeLineColor(for: tubeLine ?? .northern)
                    } else if leg.mode.name == .walking {
                        color = getJourneyColor(for: leg.mode.name)
                        text = "Walk"
                    } else {
                        color = getJourneyColor(for: leg.mode.name)
                    }
                    mutableAttributedString.append(createAttributedString(text, color: color))
                    if index < leg.routeOptions.count - 1 {
                        mutableAttributedString.append(NSAttributedString(string: ", "))
                    }
                }
                if index < journey.legs.count - 1 {
                    mutableAttributedString.append(NSAttributedString(string: " | "))
                }
                
            } else if leg.mode.name == .walking && (index == 0 || index == journey.legs.count-1) {
                color = getJourneyColor(for: leg.mode.name)
                text = "Walk"
                mutableAttributedString.append(createAttributedString(text, color: color))
                if index < journey.legs.count - 1 {
                    mutableAttributedString.append(NSAttributedString(string: " | "))
                }
            }
            
            
            
        }
        print(mutableAttributedString)
        return mutableAttributedString
    }
    
    private func createAttributedString(_ text: String, color: UIColor) -> NSAttributedString {
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color ])
        return attributedString
    }
    
    private func getJourneyColor(for transportType: TransportTypes) -> UIColor {
        switch transportType {
        case .walking: return UIColor(r: 0, g: 0, b: 0, a: 1)
        case .tube: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .tram: return UIColor(r: 0, g: 189, b: 25, a: 1)
        case .tflrail: return UIColor(r: 0, g: 25, b: 168, a: 1)
        case .taxi: return UIColor(r: 132, g: 128, b: 215, a: 1)
        case .riverBus: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .replacementBus: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .plane: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .overground: return UIColor(r: 239, g: 123, b: 16, a: 1)
        case .nationalRail: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .internationalRail: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .dlr: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .cycleHire: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .cycle: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .coach: return UIColor(r: 241, g: 171, b: 0, a: 1)
        case .bus: return UIColor(r: 220, g: 36, b: 31, a: 1)
        default: return UIColor(r: 0, g: 0, b: 0, a: 1)
        }
    }
    
    private func getTubeLineColor(for tubeLine: TubeLines) -> UIColor {
        switch tubeLine {
        case .bakerloo: return UIColor(r: 187, g: 99, b: 0, a: 1)
        case .central: return UIColor(r: 220, g: 36, b: 31, a: 1)
        case .circle: return UIColor(r: 255, g: 211, b: 41, a: 1)
        case .district: return UIColor(r: 0, g: 125, b: 50, a: 1)
        case .hammersmithAndCity: return UIColor(r: 244, g: 169, b: 190, a: 1)
        case .jubilee: return UIColor(r: 161, g: 165, b: 167, a: 1)
        case .metropolitan: return UIColor(r: 155, g: 0, b: 88, a: 1)
        case .northern: return UIColor(r: 0, g: 0, b: 0, a: 1)
        case .picadilly: return UIColor(r: 0, g: 25, b: 168, a: 1)
        case .victoria: return UIColor(r: 0, g: 152, b: 216, a: 1)
        case .waterlooAndCity: return UIColor(r: 147, g: 206, b: 186, a: 1)
        }
    }
}


enum TubeLines: String {
    case bakerloo = "bakerloo"
    case central = "central"
    case circle = "circle"
    case district = "district"
    case hammersmithAndCity = "hammersmith-city"
    case jubilee = "jubilee"
    case metropolitan = "metropolitan"
    case northern = "northern"
    case picadilly = "picadilly"
    case victoria = "victoria"
    case waterlooAndCity = "waterloo-city"
}

enum TransportTypes: String, Decodable {
    case walking = "walking"
    case tube = "tube"
    case tram = "tram"
    case tflrail = "tflrail"
    case taxi = "taxi"
    case riverTour = "river-tour"
    case riverBus = "river-bus"
    case replacementBus = "replacement-bus"
    case plane = "plane"
    case overground = "overground"
    case nationalRail = "national-rail"
    case internationalRail = "international-rail"
    case interchangeSecure = "interchange-secure"
    case interchangeKeepSitting = "interchange-keep-sitting"
    case dlr = "dlr"
    case cycleHire = "cycle-hire"
    case cycle = "cycle"
    case coach = "coach"
    case cableCar = "cable-car"
    case bus = "bus"
}
