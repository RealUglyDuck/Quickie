//
//  HeaderView.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 18/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Favourites"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
        backgroundColor = ColorCollection.mainColor
        layer.masksToBounds = true
        layer.cornerRadius = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(label)
        label.constraintsTo(top: topAnchor, leading: nil, trailing: trailingAnchor, bottom: bottomAnchor)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
}
