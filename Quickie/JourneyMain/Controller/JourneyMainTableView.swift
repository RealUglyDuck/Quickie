//
//  JourneyMainTableView.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 18/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

extension JourneyMainScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = HeaderView()
            return header
        } else {
            return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ))
        }
        
    }
}

extension JourneyMainScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return 20
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.locationCellID, for: indexPath) as? CurrentLocationCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.addressCellID, for: indexPath) as? AddressCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
}

