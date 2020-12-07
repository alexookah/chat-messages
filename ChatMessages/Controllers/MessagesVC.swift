//
//  MessagesVC.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

class MessagesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let messagesViewModel = MessagesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? UINavigationController,
           let composeMessageVC = nvc.viewControllers.first as? ComposeMessageVC {
            composeMessageVC.messagesViewModel = messagesViewModel
        }
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

// MARK: UITableViewDataSource

extension MessagesVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return messagesViewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesViewModel.sections[section].messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessagesPreviewCell.reuseIdentifier,
                                                            for: indexPath) as? MessagesPreviewCell
        else { return UITableViewCell()}

        let message = messagesViewModel.sections[indexPath.section].messages[indexPath.row]

        cell.config(with: message)

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            // last row
            cell.dropShadow(color: UIColor.appColor(.darkerGrey) ?? .black, opacity: 0.4,
                            offSet: CGSize(width: -1, height: 6), radius: 7, scale: true)
        }
    }

}
