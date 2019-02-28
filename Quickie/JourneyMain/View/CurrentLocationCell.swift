//
//  CurrentLocationCell.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 24/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class CurrentLocationCell: UITableViewCell {

    //#MARK: ----------- PROPERTIES
    
    let bgView = CellBGView()
    
    let locationIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: ImageDatabase.locationIcon)
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Location"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = ColorCollection.mainColor
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(bgView)
        bgView.addSubview(locationIcon)
        bgView.addSubview(mainLabel)
        
        _ = bgView.constraintWithDistanceTo(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topDistance: 7.5, leftDistance: 0, rightDistance: 0, bottomDistance: 7.5)
        
        _ = mainLabel.constraintWithDistanceTo(top: bgView.topAnchor, leading: locationIcon.trailingAnchor, trailing: bgView.trailingAnchor, bottom: bgView.bottomAnchor, topDistance: 15, leftDistance: 15, rightDistance: 15, bottomDistance: 15)
        
        _ = locationIcon.constraintWithDistanceTo(top: mainLabel.topAnchor, leading: bgView.leadingAnchor, trailing: nil, bottom: mainLabel.bottomAnchor, topDistance: 0, leftDistance: 15, rightDistance: 15, bottomDistance: 0)
        locationIcon.setSize(width: 20, height: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
