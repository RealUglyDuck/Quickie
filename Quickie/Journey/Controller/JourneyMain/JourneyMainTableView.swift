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
        
        guard let textField = self.activeSearchTextField as? SearchTextField else { return }
        let section = indexPath.section
        
        if section == 0 {
            
            guard let location = locationManager.location?.coordinate else { return }
            
            let place = PlaceItem(name: "Current Location", detailedName: "", coordinate: location)
            
            switch textField.textFieldType {
            case .departure: self.departure = place
            case .destination: self.destination = place
            }
            
            self.activeSearchTextField?.endEditing(true)
            self.updateTextFields()
        }
        
        if section == 1 {
            
            let request = MKLocalSearch.Request(completion: searchCompleter.results[indexPath.row])
            let search = MKLocalSearch(request: request)
            
            
            search.start { (response, error) in

                guard let response = response else { return }
                guard let activeSearchTextField = self.activeSearchTextField as? SearchTextField else { return }

                if response.mapItems.count > 1 {
                    let nearbyController = NearbyLocationsVC()
                    nearbyController.mapItems = response.mapItems
                    nearbyController.querry = self.searchCompleter.results[indexPath.row].title
                    nearbyController.textFieldType = activeSearchTextField.textFieldType
                    nearbyController.selectionDelegate = self
                    self.activeSearchTextField?.endEditing(true)
                    self.updateTextFields()
                    self.navigationController?.pushViewController(nearbyController, animated: true)
                } else {
                    let placemark = response.mapItems[0].placemark
                    let searchCompletion = self.searchCompleter.results[indexPath.row]
                    let place = PlaceItem(searchCompletion: searchCompletion, placemark: placemark)
                    
                    switch textField.textFieldType {
                        case .departure: self.departure = place
                        case .destination: self.destination = place
                    }
                }

                self.activeSearchTextField?.endEditing(true)
                self.updateTextFields()

            }
        }
        if section == 2 {
            if let textField = activeSearchTextField as? SearchTextField {
                guard let cell = tableView.cellForRow(at: indexPath) as? AddressCell else { return }
                if let place = favouritesDataManager.getFavouritePlace(cell.mainLabel.text ?? "") {
                    switch textField.textFieldType {
                    case .departure: self.departure = place
                    case .destination: self.destination = place
                    
                    textField.endEditing(true)
                    updateTextFields()
                    }
                }
            } else {
                
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
            guard let places = favouritesDataManager.favouritePlaces else { return 0 }
            if places.count == 0 {
                return 0
            } else {
                return places.count
            }
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
                cell.favouriteButtonArea.addTarget(self, action: #selector(favouritesButtonPressed(sender:)), for: .touchUpInside)
                return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.favouritesCellID, for: indexPath) as? AddressCell else { return UITableViewCell() }
            
            guard let places = favouritesDataManager.favouritePlaces else { return UITableViewCell() }
            let place = places[indexPath.row]
            cell.mainLabel.text = place.name
            cell.detailsLabel.text = place.subtitle
            return cell
        }
        return UITableViewCell()
    }
    
    
    
}

