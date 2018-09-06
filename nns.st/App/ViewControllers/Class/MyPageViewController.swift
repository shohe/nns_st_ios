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
    
    private var sourceField: UITextField?
    private var user: User = User()
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
        return viewController
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureObserver()
        self.fetchUser()
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
        tableView.register(MypageStatusCommentCell.nib, forCellReuseIdentifier: MypageStatusCommentCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }
    
}


// MARK: - IBAction
extension MyPageViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        sourceField?.resignFirstResponder()
    }
    
}


// MARK: - private function
extension MyPageViewController {
    
    private func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        if let userInfo = notification?.userInfo {
            if let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue, let _ = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
                self.view.transform = CGAffineTransform.identity
                let duplicateHeight: CGFloat = checkDuplicateHeight(baseFrame: keyboardFrame)
                if duplicateHeight > 0 { return }
                self.view.transform = CGAffineTransform(translationX: 0, y: duplicateHeight - 12.0)
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
    }
    
    private func checkDuplicateHeight(baseFrame: CGRect) -> CGFloat {
        let convertedKeyboardFrame = self.view.convert(baseFrame, from: nil)
        let convertedFieldFrame = sourceField!.convert(sourceField!.frame, to: self.view)
        let height = convertedKeyboardFrame.minY - convertedFieldFrame.minY
        print("convertedKeyboardFrame-minY: \(convertedKeyboardFrame.minY)")
        print("convertedFieldFrame-minY: \(convertedFieldFrame.minY)")
        print("height: \(height)")
        return height
    }
    
    private func fetchUser() {
        API.userGetRequest { (result) in
            if let res = result {
                self.user = res.item
                self.tableView.reloadData()
            }
        }
    }
    
}


// MARK: - UITableViewDataSource
extension MyPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypageThumbnailCell.identifier, for: indexPath) as? MypageThumbnailCell {
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypageNameCell.identifier, for: indexPath) as? MypageNameCell {
                cell.name.delegate = self
                cell.name.text = user.name
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypageMailAddressCell.identifier, for: indexPath) as? MypageMailAddressCell {
                cell.mailAddress.delegate = self
                cell.mailAddress.text = user.email
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypagePasswordCell.identifier, for: indexPath) as? MypagePasswordCell {
                cell.passwordField.delegate = self
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MypageStatusCommentCell.identifier, for: indexPath) as? MypageStatusCommentCell {
                cell.statusComment.delegate = self
                cell.statusComment.text = user.statusComment
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


// MARK: - UITextFieldDelegate
extension MyPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.sourceField = textField
        return true
    }
    
}
