//
//  ComposeMessageContentCell.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 7/12/20.
//

import UIKit

protocol GrowingTextViewProtocol: AnyObject {
    func updateHeightOfRow(_ cell: ComposeMessageContentCell, _ textView: UITextView)
}

class ComposeMessageContentCell: UITableViewCell {

    static let reuseIdentifier: String = "ComposeMessageContentCell"

    weak var cellDelegate: GrowingTextViewProtocol?
    weak var messageCellDelegate: NewMessageCellDelegate?

    @IBOutlet weak var messageContent: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config() {
        messageContent.textContainer.heightTracksTextView = true
        messageContent.delegate = self
    }
}

extension ComposeMessageContentCell: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        cellDelegate?.updateHeightOfRow(self, messageContent)
        messageCellDelegate?.updateNewMessage(with: textView.text, type: .content)
    }
}
