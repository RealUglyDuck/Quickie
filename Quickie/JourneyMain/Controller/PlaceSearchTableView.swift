//
//  PlaceSearchTableView.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 25/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import MapKit

extension PlaceSearchVC: UITableViewDelegate {
    
}

extension PlaceSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCompleter.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.locationCellID, for: indexPath) as? AddressCell else {
            return UITableViewCell()
        }
        
        let place = searchCompleter.results[indexPath.row]
        cell.mainLabel.text = place.title
        cell.detailsLabel.text = place.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = MKLocalSearch.Request(completion: searchCompleter.results[indexPath.row])
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            
            guard let response = response else { return }

            let location = response.mapItems[0].placemark
            print(location.coordinate)
            let title = self.searchCompleter.results[indexPath.row].title
            let subtitle = self.searchCompleter.results[indexPath.row].subtitle
            let place = PlaceItem(name: title, detailedName: subtitle, placemark: location)
            
            self.selectionDelegate.didSelectPlace(place: place, textFieldType: self.textFieldType)
            self.navigationController?.popToRootViewController(animated: true)

        }
        
    }
    
    func dismissViewController() {
//
    }
}
