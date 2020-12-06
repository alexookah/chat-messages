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
    let content: String

    let time: String
    let attachment: URL?

    var containsAttachment: Bool {
        return attachment != nil
    }

    var senderNameInitials: String {
        return senderName.split(separator: " ").compactMap({ String($0.first ?? Character("")) }).joined()
    }

    let isUnread: Bool
}
