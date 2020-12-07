//
//  MessagesVC.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

protocol MessagesVCDelegate: AnyObject {
    func reloadData()
}

class MessagesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let messagesViewModel = MessagesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUnreadMessagesBadge()
    }

    func updateUnreadMessagesBadge() {
        if let tabBarController = tabBarController {
            var totalUnread = 0
            messagesViewModel.sections.forEach({ section in
                totalUnread += section.messages.filter({ $0.isUnread }).count
            })
            tabBarController.tabBar.items?[3].badgeValue = totalUnread > 0 ? totalUnread.description : nil
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? UINavigationController,
           let composeMessageVC = nvc.viewControllers.first as? ComposeMessageVC {
            composeMessageVC.messagesViewModel = messagesViewModel
            composeMessageVC.messagesVCDelegate = self
        }
    }

}

// MARK: UITableViewDataSource

extension MessagesVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return messagesViewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let messagesOfSection = messagesViewModel.sections[section].messages.count

        return messagesOfSection == 0 ? 1 : messagesOfSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let messagesOfSection = messagesViewModel.sections[indexPath.section].messages

        switch messagesOfSection.count {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MessagesEmptySectionCell.reuseIdentifier,
                                                                for: indexPath) as? MessagesEmptySectionCell
            else { return UITableViewCell()}

            cell.title.text = messagesViewModel.sections[indexPath.section].emptySectionText

            // hide last seperator
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MessagesPreviewCell.reuseIdentifier,
                                                                for: indexPath) as? MessagesPreviewCell
            else { return UITableViewCell()}

            let message = messagesOfSection[indexPath.row]

            cell.config(with: message)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1,
           !messagesViewModel.sections[indexPath.section].messages.isEmpty {
            // last row
            cell.dropShadow(color: UIColor.appColor(.darkerGrey) ?? .black, opacity: 0.4,
                            offSet: CGSize(width: -1, height: 6), radius: 7, scale: true)
        }
    }
}

// MARK: UITableViewActions

extension MessagesVC {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                                indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if messagesViewModel.sections[indexPath.section].messages.isEmpty {
            return nil
        }

        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }

    // MARK: - Contextual DELETE Actions
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in

            self.removeRows(indexPath: indexPath)
            completion(true)
        }
    }

    private func removeRows(indexPath: IndexPath) {
        messagesViewModel.sections[indexPath.section].messages.remove(at: indexPath.row)

        tableView.beginUpdates()

        if messagesViewModel.sections[indexPath.section].messages.isEmpty {
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

        tableView.endUpdates()

        updateUnreadMessagesBadge()
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt
                    indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if messagesViewModel.sections[indexPath.section].messages.isEmpty {
            return nil
        }
        let isUnread = messagesViewModel.sections[indexPath.section].messages[indexPath.row].isUnread

        return UISwipeActionsConfiguration(actions: [
            makeReadContextualAction(forRowAt: indexPath, isUnread: isUnread)
        ])
    }

    // MARK: - Contextual READ Actions
    private func makeReadContextualAction(forRowAt indexPath: IndexPath, isUnread: Bool) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: isUnread ? "Read" : "Unread") { (_, _, completion) in

            self.markMessagesAsRead(indexPath: indexPath, isUnread: isUnread)
            completion(true)
        }
    }

    private func markMessagesAsRead(indexPath: IndexPath, isUnread: Bool) {

        messagesViewModel.sections[indexPath.section].messages[indexPath.row].isUnread = !isUnread

        let message = messagesViewModel.sections[indexPath.section].messages[indexPath.row]

        (tableView.cellForRow(at: indexPath) as? MessagesPreviewCell)?.config(with: message)

        updateUnreadMessagesBadge()
    }
}

// MARK: UITableViewDelegate

extension MessagesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = MessagesSectionView.instanceFromNib() else { return nil }

        headerView.title.text = messagesViewModel.sections[section].titleShown

        return headerView
    }
}

// MARK: MessagesVCDelegate

extension MessagesVC: MessagesVCDelegate {

    func reloadData() {
        updateUnreadMessagesBadge()
        tableView.reloadData()
    }

}
