//
//  SearchTextField.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 18/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorCollection.backgroundColor
        textColor = ColorCollection.mainColor
        layer.masksToBounds = true
        layer.cornerRadius = 4
        font = UIFont.systemFont(ofSize: 14)
        keyboardType = .default
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
