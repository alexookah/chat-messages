//
//  MessagesSectionView.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 5/12/20.
//

import UIKit

class MessagesSectionView: UIView {

    @IBOutlet weak var title: UILabel!

    class func instanceFromNib() -> MessagesSectionView? {
        return UINib(nibName: "MessagesSectionView",
                     bundle: nil).instantiate(withOwner: nil, options: nil).first as? MessagesSectionView
    }
}
