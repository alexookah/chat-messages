//
//  ComposeMessageSenderNameCell.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 7/12/20.
//

import UIKit

enum NewMessageTypeField {
    case senderName
    case subject
    case content
}

protocol NewMessageCellDelegate: AnyObject {
    func updateNewMessage(with text: String, type: NewMessageTypeField)
}

class ComposeMessageSenderNameCell: UITableViewCell {

    static let reuseIdentifier: String = "ComposeMessageSenderNameCell"

    weak var messageCellDelegate: NewMessageCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func senderNameEditingChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        messageCellDelegate?.updateNewMessage(with: text, type: .senderName)
    }

}
