//
//  MessagesPreviewCell.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

class MessagesPreviewCell: UITableViewCell {

    static let reuseIdentifier = "MessagesPreviewCell"

    @IBOutlet weak var messageStatusView: CustomView!
    @IBOutlet weak var senderNameButton: CustomButton!
    @IBOutlet weak var senderFullName: UILabel!
    @IBOutlet weak var messageSubject: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var messageAttachment: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(with message: Message) {

        messageStatusView.isHidden = !message.isUnread
        senderNameButton.setTitle(message.senderNameInitials, for: .normal)

        // show empty string to keep the height cell same as others
        messageSubject.text = message.subject.isEmpty ? " " : message.content
        messageContent.text = message.content.isEmpty ? " " : message.content

        messageTime.text = message.time
        messageAttachment.isHidden = !message.containsAttachment

        senderFullName.text = message.senderName

        if message.isUnread {
            senderFullName.textColor = .black
            messageSubject.textColor = .black
        } else {
            senderFullName.textColor = .appColor(.darkGrey)
            messageSubject.textColor = .appColor(.darkGrey)
        }
    }

}
