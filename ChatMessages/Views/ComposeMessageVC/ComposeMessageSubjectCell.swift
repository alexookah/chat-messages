//
//  ComposeMessageSubjectCell.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 7/12/20.
//

import UIKit

class ComposeMessageSubjectCell: UITableViewCell {

    static let reuseIdentifier: String = "ComposeMessageSubjectCell"

    weak var messageCellDelegate: NewMessageCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func subjectEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        messageCellDelegate?.updateNewMessage(with: text, type: .subject)
    }

}
