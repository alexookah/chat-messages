//
//  UIButton.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

    @IBInspectable var isCircle: Bool = false {
        didSet {
            if isCircle {
                layer.cornerRadius = layer.frame.height / 2
            }
        }
    }
}
