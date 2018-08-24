//
//  MyPageViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/24.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
        return viewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(MypageThumbnailCell.nib, forCellReuseIdentifier: MypageThumbnailCell.identifier)
        tableView.register(MypageNameCell.nib, forCellReuseIdentifier: MypageNameCell.identifier)
        tableView.register(MypageMailAddressCell.nib, forCellReuseIdentifier: MypageMailAddressCell.identifier)
        tableView.register(MypagePasswordCell.nib, forCellReuseIdentifier: MypagePasswordCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - IBAction
extension MyPageViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UITableViewDataSource
extension MyPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypageThumbnailCell.identifier, for: indexPath) as? MypageThumbnailCell {
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypageNameCell.identifier, for: indexPath) as? MypageNameCell {
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypageMailAddressCell.identifier, for: indexPath) as? MypageMailAddressCell {
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypagePasswordCell.identifier, for: indexPath) as? MypagePasswordCell {
                return cell
            }
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - UITableViewDelegate
extension MyPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
