//
//  ComposeMessageVC.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 7/12/20.
//

import UIKit

class ComposeMessageVC: UITableViewController {

    var messagesViewModel: MessagesViewModel!

    var newMessage: Message!

    override func viewDidLoad() {
        super.viewDidLoad()

        newMessage = messagesViewModel.composeMessage()

        // hide extra seperators
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComposeMessageSenderNameCell.reuseIdentifier,
                                                           for: indexPath) as? ComposeMessageSenderNameCell
            else { return UITableViewCell() }

            cell.messageCellDelegate = self

            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComposeMessageSubjectCell.reuseIdentifier,
                                                     for: indexPath) as? ComposeMessageSubjectCell
            else { return UITableViewCell() }

            cell.messageCellDelegate = self

            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComposeMessageContentCell.reuseIdentifier,
                                                     for: indexPath) as? ComposeMessageContentCell
            else { return UITableViewCell() }

            cell.config()

            cell.cellDelegate = self
            cell.messageCellDelegate = self

            return cell
        default:
            return UITableViewCell()
        }
    }

    @IBAction func didTapOnSendMessage(_ sender: UIBarButtonItem) {
        messagesViewModel.sections[0].messages.append(newMessage)
    }

}

extension ComposeMessageVC: NewMessageCellDelegate {
    func updateNewMessage(with text: String, type: NewMessageTypeField) {
        switch type {
        case .senderName:
            newMessage.senderName = text
        case .subject:
            newMessage.subject = text
        case .content:
            newMessage.content = text
        }
    }

}

// MARK: GrowingTextViewProtocol

extension ComposeMessageVC: GrowingTextViewProtocol {

    func updateHeightOfRow(_ cell: ComposeMessageContentCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width,
                                                        height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
