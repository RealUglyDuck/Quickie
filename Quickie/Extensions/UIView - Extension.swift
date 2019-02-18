//
//  UIViewExtensions.swift
//  WannaBee
//
//  Created by Paweł Ambrożej on 06/01/2019.
//  Copyright © 2019 Pawel Ambrozej. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func constraintAnchors(top:NSLayoutYAxisAnchor?, leading:NSLayoutXAxisAnchor?, trailing:NSLayoutXAxisAnchor?, bottom:NSLayoutYAxisAnchor?, topDistance: CGFloat, leftDistance: CGFloat, rightDistance: CGFloat, bottomDistance: CGFloat, height: CGFloat?, width: CGFloat?) -> [NSLayoutConstraint] {
        
        let constraints = constraintWithDistanceTo(top: top, leading: leading, trailing: trailing, bottom: bottom, topDistance: topDistance, leftDistance: leftDistance, rightDistance: rightDistance, bottomDistance: bottomDistance)
        
        setSize(width: width, height: height)
        
        return constraints
        
    }
    
    func constraintsTo(top:NSLayoutYAxisAnchor?, leading:NSLayoutXAxisAnchor?, trailing:NSLayoutXAxisAnchor?, bottom:NSLayoutYAxisAnchor?) {
        
        _ = self.constraintWithDistanceTo(top: top, leading: leading, trailing: trailing, bottom: bottom, topDistance: 0, leftDistance: 0, rightDistance: 0, bottomDistance: 0)
        
    }
    
    func constraintWithDistanceTo(top:NSLayoutYAxisAnchor?, leading:NSLayoutXAxisAnchor?, trailing:NSLayoutXAxisAnchor?, bottom:NSLayoutYAxisAnchor?, topDistance: CGFloat, leftDistance: CGFloat, rightDistance: CGFloat, bottomDistance: CGFloat)->[NSLayoutConstraint]{
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        if let top = top {
            let constraint = self.topAnchor.constraint(equalTo: top, constant: topDistance)
            constraint.isActive = true
            constraint.identifier = "topAnchorConstraint"
            constraints.append(constraint)
        }
        
        if let leading = leading {
            let constraint = self.leadingAnchor.constraint(equalTo: leading, constant: leftDistance)
            constraint.isActive = true
            constraint.identifier = "leftAnchorConstraint"
            constraints.append(constraint)
        }
        
        if let trailing = trailing {
            let constraint = self.trailingAnchor.constraint(equalTo: trailing, constant: -rightDistance)
            constraint.isActive = true
            constraint.identifier = "rightAnchorConstraint"
            constraints.append(constraint)
        }
        
        if let bottom = bottom {
            let constraint = self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomDistance)
            constraint.isActive = true
            constraint.identifier = "bottomAnchorConstraint"
            constraints.append(constraint)
        }
        return constraints
    }
    
    func constraintToSuperView() {
        if let superview = superview {
            constraintsTo(top: superview.topAnchor, leading: superview.leadingAnchor, trailing: superview.trailingAnchor, bottom: superview.bottomAnchor)
        }
    }
    
    func constraintToSuperViewWith(margin:CGFloat) {
        if let superview = superview {
            _ = constraintWithDistanceTo(top: superview.topAnchor, leading: superview.leadingAnchor, trailing: superview.trailingAnchor, bottom: superview.bottomAnchor, topDistance: margin, leftDistance: margin, rightDistance: margin, bottomDistance: margin)
        }
    }
    
    func centerInTheView(centerX:NSLayoutXAxisAnchor?, centerY:NSLayoutYAxisAnchor?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
    }
    
    func setSize(width:CGFloat?, height:CGFloat?) {
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func constraintWith(visualFormat:String,views:UIView...) {
        
        var viewsDict:Dictionary<String,UIView> = [:]
        
        for index in views.indices {
            
            views[index].translatesAutoresizingMaskIntoConstraints = false
            let viewName = "v\(index)"
            viewsDict[viewName] = views[index]
        }
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
    }
    
    
}

enum Constraint {
    case leading
    case trailing
    case top
    case bottom
}
