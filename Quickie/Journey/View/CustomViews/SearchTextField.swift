//
//  SearchTextField.swift
//  Quickie
//
//  Created by Paweł Ambrożej on 18/02/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import UIKit

public enum SearchTextFieldType {
    case destination
    case departure
}

class SearchTextField: UITextField {
    
    let mapButton: UIButton = {
        let image = UIImage(named:ImageDatabase.searchOnMapIcon)
        let button = UIButton()
        let mapButton = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 24))
        mapButton.setBackgroundImage(image, for: .normal)
        mapButton.setBackgroundImage(image, for: .highlighted)
        mapButton.contentMode = .center
        return mapButton
    }()
    
    var textFieldType: SearchTextFieldType = .departure
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorCollection.backgroundColor
        textColor = ColorCollection.mainColor
        layer.masksToBounds = true
        layer.cornerRadius = 4
        font = UIFont.systemFont(ofSize: 14)
        keyboardType = .default
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        let mapView = mapButton
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = mapView
        self.rightViewMode = .whileEditing
//        self.clearButtonMode = ViewMode.whileEditing
        
    }
    
    convenience init(type: SearchTextFieldType) {
        self.init(frame: .zero)
        textFieldType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
