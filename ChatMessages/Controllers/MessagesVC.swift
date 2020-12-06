//
//  MessagesVC.swift
//  ChatMessages
//
//  Created by Alexandros Lykesas on 6/12/20.
//

import UIKit

class MessagesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: UITableViewDelegate

extension MessagesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = MessagesSectionView.instanceFromNib() else { return nil }
        headerView.title.text = "Read receipts"

        return headerView
    }
}

// MARK: UITableViewDataSource

extension MessagesVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessagesPreviewCell.reuseIdentifier,
                                                            for: indexPath) as? MessagesPreviewCell
        else { return UITableViewCell()}

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            cell.dropShadow(color: UIColor.appColor(.darkerGrey) ?? .black, opacity: 0.35,
                            offSet: CGSize(width: -1, height: 6), radius: 6, scale: false)

            // first row
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            // last row
            cell.dropShadow(color: UIColor.appColor(.darkerGrey) ?? .black, opacity: 0.4,
                            offSet: CGSize(width: -1, height: 6), radius: 7, scale: false)
        }
    }

}
