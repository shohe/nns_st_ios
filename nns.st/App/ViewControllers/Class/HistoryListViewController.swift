//
//  HistoryListViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class HistoryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var historyItems: [OfferHistoryListGetItem] = []
    
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HTNavigationController") as! UINavigationController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(HistoryCell.nib, forCellReuseIdentifier: HistoryCell.identifier)
        
        self.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - private
extension HistoryListViewController {
    
    private func fetch() {
        API.offerHistoryListGetRequest { (result) in
            if let res = result {
                self.historyItems = res.item
                self.tableView.reloadData()
            }
        }
    }
    
}


// MARK: - IBAction
extension HistoryListViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UITableViewDataSource
extension HistoryListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell {
            cell.selectionStyle = .none
            cell.setItem(item: self.historyItems[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}


// MARK: - UITableViewDelegate
extension HistoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.historyItems[indexPath.row].id
        self.navigationController?.pushViewController(HistoryInfoViewController.instantiateViewController(offerId: id), animated: true)
    }
    
}
