//
//  ConfirmRequestViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ConfirmRequestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Confirm", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CRNavigationController") as! UINavigationController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(StylistProfileWithStarCell.nib, forCellReuseIdentifier: StylistProfileWithStarCell.identifier)
        tableView.register(PriceButtonCell.nib, forCellReuseIdentifier: PriceButtonCell.identifier)
        tableView.register(SalonAddressCell.nib, forCellReuseIdentifier: SalonAddressCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - Navigation
extension ConfirmRequestViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UITableViewDelegate
extension ConfirmRequestViewController: UITableViewDelegate {
    
}


// MARK: - UITableViewDataSource
extension ConfirmRequestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: StylistProfileWithStarCell.identifier, for: indexPath) as! StylistProfileWithStarCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: PriceButtonCell.identifier, for: indexPath) as! PriceButtonCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: SalonAddressCell.identifier, for: indexPath) as! SalonAddressCell
        default:
            cell = UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return StylistProfileWithStarCell.height
        case 1:
            return PriceButtonCell.height
        case 2:
            return SalonAddressCell.height
        default:
            return 50
        }
    }
    
}
