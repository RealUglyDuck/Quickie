//
//  JourneyOptionCell.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 09/03/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class JourneyOptionCell: UITableViewCell {

    lazy var bgView = CellBGView()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Absolute Living"
        label.numberOfLines = 0
        label.textColor = ColorCollection.mainColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "143A Battersea High Street"
        label.textColor = ColorCollection.secondaryColor
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "52 min"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = ColorCollection.mainColor
        label.textAlignment = .right
        return label
    }()
    
    //#MARK: ----------- INITIALIZATION
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bgView.backgroundColor = UIColor.white
        setupViews()
        layer.masksToBounds = false
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(bgView)
        bgView.addSubview(mainLabel)
        bgView.addSubview(detailsLabel)
        bgView.addSubview(totalTimeLabel)
        
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTimeLabel.setSize(width: 70, height: 20)
        totalTimeLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -15).isActive = true
        totalTimeLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        
        _ = bgView.constraintWithDistanceTo(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topDistance: 7.5, leftDistance: 0, rightDistance: 0, bottomDistance: 7.5)
        _ = mainLabel.constraintWithDistanceTo(top: bgView.topAnchor, leading: bgView.leadingAnchor, trailing: totalTimeLabel.leadingAnchor, bottom: detailsLabel.topAnchor, topDistance: 13, leftDistance: 13, rightDistance: 15, bottomDistance: 5)
        _ = detailsLabel.constraintWithDistanceTo(top: nil, leading: mainLabel.leadingAnchor, trailing: mainLabel.trailingAnchor, bottom: bgView.bottomAnchor, topDistance: 0, leftDistance: 0, rightDistance: 0, bottomDistance: 13)
        
    }

}
