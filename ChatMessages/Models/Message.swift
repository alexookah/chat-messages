//
//  Message.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import Foundation

struct Message {

    var senderName: String
    var subject: String
    var content: String

    var time: String
    var attachment: URL?

    var containsAttachment: Bool {
        return attachment != nil
    }

    var senderNameInitials: String {
        return senderName.split(separator: " ").compactMap({ String($0.first ?? Character("")) }).joined()
    }

    var isUnread: Bool
}
