//
//  Message.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import Foundation

struct Message {
    let senderName: String
    let subject: String
    let context: String
    let attachment: Bool

    var senderNameInitials: String {
        return senderName.split(separator: " ").compactMap({ String($0.first ?? Character("")) }).joined()
    }
}
