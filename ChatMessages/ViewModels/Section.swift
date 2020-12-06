//
//  File.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import Foundation

enum SectionType {
    case receipt
    case message
}

struct Section {

    let titleSingular: String
    let titlePlular: String

    let type: SectionType

    var messages: [Message] = []

    var titleShown: String {
        messages.count == 1 ? titleSingular : titlePlular
    }

}
