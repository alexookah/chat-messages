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
        let demoReceiptSection = MockData.shared.createDemoReceipt()
        sections.append(demoReceiptSection)

        let demoMessagesSection = MockData.shared.createDemoMessages()
        sections.append(demoMessagesSection)
    }

    func createNewMessage() -> Message {
        return Message(senderName: "", subject: "", content: "", time: "", attachment: nil, isUnread: true)
    }

    func addNewMessage(_ message: Message, type: SectionType) {
        guard let sectionIndexToAddMessage = sections.firstIndex(where: { $0.type == type }) else { return }
        sections[sectionIndexToAddMessage].messages.append(message)
    }
}
