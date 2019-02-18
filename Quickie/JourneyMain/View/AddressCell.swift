//
//  AddressCell.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 18/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    let bgView = UIView()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Absolute Living"
        label.textColor = ColorCollection.mainColor
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "143A Battersea High Street"
        label.textColor = ColorCollection.secondaryColor
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        addSubview(bgView)
        _ = bgView.constraintWithDistanceTo(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topDistance: 7.5, leftDistance: 0, rightDistance: 0, bottomDistance: 7.5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
