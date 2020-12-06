//
//  CustomView.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

@IBDesignable class CustomView: UIView {

    @IBInspectable var isCircle: Bool = false {
        didSet {
            if isCircle {
                layer.cornerRadius = layer.frame.height / 2
            }
        }
    }

    @IBInspectable var gradientTopColor: UIColor?
    @IBInspectable var gradientBottomColor: UIColor?

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        if let gradientTopColor = gradientTopColor, let gradientBottomColor = gradientBottomColor {
            (layer as? CAGradientLayer)?.colors = [gradientTopColor.cgColor, gradientBottomColor.cgColor]
        }
    }

}
