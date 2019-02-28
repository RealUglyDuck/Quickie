//
//  AddressCell.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 18/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    //#MARK: ----------- PROPERTIES
    
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
    
    let favouriteButton: UIImageView = {
        let favourite = UIImageView()
        favourite.image = UIImage(named: ImageDatabase.favouriteIconActive)
        favourite.contentMode = .scaleAspectFit
        return favourite
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
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //#MARK: ----------- SETUPS
    
    func setupViews() {
        
        addSubview(bgView)
        bgView.addSubview(mainLabel)
        bgView.addSubview(detailsLabel)
        bgView.addSubview(favouriteButton)
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.setSize(width: 20, height: 20)
        favouriteButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -15).isActive = true
        favouriteButton.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        
        _ = bgView.constraintWithDistanceTo(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topDistance: 7.5, leftDistance: 0, rightDistance: 0, bottomDistance: 7.5)
        _ = mainLabel.constraintWithDistanceTo(top: bgView.topAnchor, leading: bgView.leadingAnchor, trailing: favouriteButton.leadingAnchor, bottom: detailsLabel.topAnchor, topDistance: 13, leftDistance: 13, rightDistance: 15, bottomDistance: 5)
        _ = detailsLabel.constraintWithDistanceTo(top: nil, leading: mainLabel.leadingAnchor, trailing: mainLabel.trailingAnchor, bottom: bgView.bottomAnchor, topDistance: 0, leftDistance: 0, rightDistance: 0, bottomDistance: 13)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
