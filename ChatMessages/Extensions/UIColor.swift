//
//  UIColor.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

enum AssetsColor: String {
    case accentColor = "AccentColor"
    case darkerGrey = "DarkerGrey"
    case darkestGrey = "DarkestGrey"
    case darkGrey = "DarkGrey"
    case grey = "Grey"
    case orange = "Orange"
}

extension UIColor {

    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
