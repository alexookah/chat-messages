//
//  MessagesVIewModel.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import Foundation

class MessagesViewModel {

    var sections: [Section] = []

    init() {
        createDemoReceipt()
        createDemoMessages()
    }

    func createDemoReceipt() {

        var sectionReceipt = Section(titleSingular: "Read receipt", titlePlular: "Read receipts", type: .receipt)

        let messageReceipt = Message(senderName: "Alex Lykesas", subject: "Message Subject",
                                     content: "Hello, Would youlike to...", time: "00:00",
                                     attachment: nil, isUnread: true)
        sectionReceipt.messages.append(messageReceipt)

        addSection(section: sectionReceipt)
    }

    func createDemoMessages() {
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
                              attachment: URL(string: "https://"), isUnread: false)
        sectionMyMessages.messages.append(messageFourth)

        addSection(section: sectionMyMessages)
    }

    func addSection(section: Section) {

        if !section.messages.isEmpty {
            sections.append(section)
        }
    }

}
