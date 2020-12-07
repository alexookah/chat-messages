//
//  MockData.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 7/12/20.
//

import Foundation

class MockData {

    static var shared = MockData()

    func createDemoReceipt() -> Section {

        var sectionReceipt = Section(titleSingular: "Read receipt", titlePlular: "Read receipts", type: .receipt)

        let messageReceipt = Message(senderName: "Alex Lykesas", subject: "Message Subject",
                                     content: "Hello, Would youlike to...", time: "00:00",
                                     attachment: nil, isUnread: true)
        sectionReceipt.messages.append(messageReceipt)

        return sectionReceipt
    }

    func createDemoMessages() -> Section {
        var sectionMyMessages = Section(titleSingular: "My message", titlePlular: "My messages", type: .message)

        let messageFirst = Message(senderName: "Alex Lykesas", subject: "Message Subject",
                              content: "Hello, Would youlike to...", time: "00:00",
                              attachment: nil, isUnread: true)
        sectionMyMessages.messages.append(messageFirst)

        let messageSecond = Message(senderName: "Alex Lykesas", subject: "Message Subject",
                              content: "Hello, Would you like to...", time: "00:00",
                              attachment: nil, isUnread: true)
        sectionMyMessages.messages.append(messageSecond)

        let messageThird = Message(senderName: "Alex Lykesas", subject: "Message Subject",
                              content: "Hello, Would youlike to...", time: "00:00",
                              attachment: nil, isUnread: true)
        sectionMyMessages.messages.append(messageThird)

        let messageFourth = Message(senderName: "Alex Lykesas", subject: "Message Subject",
                              content: "Hello, Would youlike to...", time: "00:00",
                              attachment: URL(string: "https://demo_attachment.com/link.pdf"), isUnread: false)
        sectionMyMessages.messages.append(messageFourth)

        return sectionMyMessages
    }
}
