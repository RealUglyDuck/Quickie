//
//  JourneyOptionsTableView.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 09/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

extension JourneyOptionsVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension JourneyOptionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.journeyOptionCellID, for: indexPath) as? JourneyOptionCell else {
            return UITableViewCell()
        }
        cell.mainLabel.text = "170 | Victoria"
        cell.detailsLabel.text = "19:15 - Arrive at: 19:15 £3.90"
        cell.totalTimeLabel.text = "39 mins"
        
        return cell
    }
    
    
}
