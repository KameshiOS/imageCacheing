//
//  ButtonDesign.swift
//  MindValleyDemo
//
//  Created by Lalithbabu Logeshwarrao on 19/06/2017.
//  Copyright © 2017 Payzak Financial Service. All rights reserved.
//

import UIKit


@IBDesignable
class ButtonDesign: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
            clipsToBounds = true
        }
    }
    
}
