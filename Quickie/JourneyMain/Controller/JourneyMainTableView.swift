//
//  JourneyMainTableView.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 18/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit
import MapKit

extension JourneyMainScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 0
        }
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let header = HeaderView()
            return header
        } else {
            return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.activeSearchTextField?.text = "Current Location"
            self.activeSearchTextField?.endEditing(true)
        }
        
        if indexPath.section == 1 {
            let request = MKLocalSearch.Request(completion: searchCompleter.results[indexPath.row])
            let search = MKLocalSearch(request: request)
            
            search.start { (response, error) in
                
                guard let response = response else { return }
                
                let location = response.mapItems[0].placemark

                let title = self.searchCompleter.results[indexPath.row].title
                let subtitle = self.searchCompleter.results[indexPath.row].subtitle
                let place = PlaceItem(name: title, detailedName: subtitle, coordinate: location.coordinate)
                
                self.activeSearchTextField?.text = subtitle
                self.activeSearchTextField?.endEditing(true)
                
            }
        }
    }
}

extension JourneyMainScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            guard let activeSearchTextField = activeSearchTextField else { return 0 }
            if activeSearchTextField.text == nil || activeSearchTextField.text == "" {
                return 1
            } else {
                return 0
            }
            
        } else if section == 1 {
            guard let _ = activeSearchTextField else { return 0 }
            return searchCompleter.results.count
            
        } else {
            
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let activeSearchTextField = activeSearchTextField else { return UITableViewCell() }
            if activeSearchTextField.text == nil || activeSearchTextField.text == "" {
                return CurrentLocationCell()
            }
            
        } else if indexPath.section == 1 {
            guard let _ = activeSearchTextField else { return UITableViewCell() }
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.addressCellID, for: indexPath) as? AddressCell else {
                    return UITableViewCell()
                }
                
                let place = searchCompleter.results[indexPath.row]
                cell.mainLabel.text = place.title
                cell.detailsLabel.text = place.subtitle
                return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.favouritesCellID, for: indexPath) as? AddressCell else {
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    
}

