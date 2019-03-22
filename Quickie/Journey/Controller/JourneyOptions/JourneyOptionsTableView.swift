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
        if journeysDataManager != nil {
            return 1
        } else {
            return 0
        }
    }
}

extension JourneyOptionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let journeyManager = self.journeysDataManager else { return 0 }
        return journeyManager.journeysData.journeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.journeyOptionCellID, for: indexPath) as? JourneyOptionCell else {
            return UITableViewCell()
        }
        guard let journeyManager = self.journeysDataManager else { return UITableViewCell() }
        cell.mainLabel.attributedText = journeyManager.generateMainLabelString(for: indexPath.row)
        cell.detailsLabel.text = journeyManager.generateDetailsLabelString(for: indexPath.row)
        cell.totalTimeLabel.text = "\(journeyManager.journeysData.journeys[indexPath.row].duration) mins"
        cell.mainLabel.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    
}
