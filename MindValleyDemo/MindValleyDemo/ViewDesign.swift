//
//  ViewDesign.swift
//  MindValleyDemo
//
//  Created by Lalithbabu Logeshwarrao on 19/06/2017.
//  Copyright © 2017 Payzak Financial Service. All rights reserved.
//

import UIKit

@IBDesignable
class ViewDesign: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 1
            clipsToBounds = true
        }
    }
}
