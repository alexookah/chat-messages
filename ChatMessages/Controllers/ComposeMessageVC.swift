//
//  ComposeMessageVC.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 7/12/20.
//

import UIKit

class ComposeMessageVC: UITableViewController {

    @IBOutlet weak var sendButton: UIBarButtonItem!

    var messagesViewModel: MessagesViewModel!

    weak var messagesVCDelegate: MessagesVCDelegate?

    var newMessage: Message!

    override func viewDidLoad() {
        super.viewDidLoad()

        newMessage = messagesViewModel.createNewMessage()

        // hide extra seperators
        tableView.tableFooterView = UIView()
    }

    @IBAction func didTapOnCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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

            // hide last seperator
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

            return cell
        default:
            return UITableViewCell()
        }
    }

    @IBAction func didTapOnSendMessage(_ sender: UIBarButtonItem) {

        if newMessage.subject.isEmpty {
            confirmSendMessage(checkType: "Subject")
        } else if newMessage.content.isEmpty {
            confirmSendMessage(checkType: "Content")
        }
    }

    func confirmSendMessage(checkType: String) {
        let alert = UIAlertController(title: "Empty \(checkType)",
                                      message: "This message has no \(checkType). Do you want to send it anyway?",
                                      preferredStyle: .alert)

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)

        let okAction = UIAlertAction(title: "Send", style: .default, handler: { _ in
            self.sendMessage()
        })
        alert.addAction(okAction)

        present(alert, animated: true)
    }

    func sendMessage() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        newMessage.time = formatter.string(from: Date())

        messagesViewModel.addNewMessage(newMessage, type: .message)
        messagesVCDelegate?.reloadData()
        dismiss(animated: true, completion: nil)
    }

}

extension ComposeMessageVC: NewMessageCellDelegate {

    func updateNewMessage(with text: String, type: NewMessageTypeField) {
        switch type {
        case .senderName:
            sendButton.isEnabled = !text.isEmpty
            newMessage.senderName = text
        case .subject:
            title = text.isEmpty ? "New Message" : text
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
