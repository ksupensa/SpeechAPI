//
//  CircleBtn.swift
//  Write It
//
//  Created by Spencer Forrest on 20/01/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

@IBDesignable
class CircleBtn: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet{
            setupCorner()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupCorner()
    }
    
    func setupCorner(){
        layer.cornerRadius = cornerRadius
    }

}
