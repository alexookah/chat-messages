//
//  MessagesPreviewCell.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

class MessagesPreviewCell: UITableViewCell {

    static let reuseIdentifier: String = "MessagesPreviewCell"

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

//    func config(with message: Message) {
//
//    }

}
