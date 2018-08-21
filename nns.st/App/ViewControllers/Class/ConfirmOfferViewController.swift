//
//  ConfirmOfferViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ConfirmOfferViewController: UIViewController {
    
    var offerItem: OfferItem?
    var loadingView: LoadingView?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    static func instantiateViewController() -> ConfirmOfferViewController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConfirmOfferViewController") as! ConfirmOfferViewController
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(OutcomeInfoCell.nib, forCellReuseIdentifier: OutcomeInfoCell.identifier)
        tableView.register(DateInfoCell.nib, forCellReuseIdentifier: DateInfoCell.identifier)
        tableView.register(DistanceInfoCell.nib, forCellReuseIdentifier: DistanceInfoCell.identifier)
        tableView.register(HairTypeInfoCell.nib, forCellReuseIdentifier: HairTypeInfoCell.identifier)
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


extension ConfirmOfferViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OutcomeInfoCell.identifier, for: indexPath) as? OutcomeInfoCell {
                cell.setEachValue(item: offerItem)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DateInfoCell.identifier, for: indexPath) as? DateInfoCell {
                cell.setEachValue(item: offerItem)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DistanceInfoCell.identifier, for: indexPath) as? DistanceInfoCell {
                cell.setEachValue(item: offerItem)
                return cell
            }
            
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HairTypeInfoCell.identifier, for: indexPath) as? HairTypeInfoCell {
                cell.setEachValue(item: offerItem)
                return cell
            }
       default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}


extension ConfirmOfferViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let space: CGFloat = 235.0
            
            var frame: CGRect = tableView.frame
            frame.size.height = tableView.contentSize.height
            tableView.frame = frame
            
            commentTextViewHeight.constant = self.view.frame.height - tableView.frame.height - space - (self.navigationController?.navigationBar.frame.height)!
        }
    }
    
}


extension ConfirmOfferViewController {
    
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        if let userInfo = notification?.userInfo {
            if let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue, let _ = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
                
                self.view.transform = CGAffineTransform.identity
                let convertedKeyboardFrame = self.view.convert(keyboardFrame, from: nil)
                
                let space: CGFloat = 118.0
                let height: CGFloat = self.view.frame.height - space
                let offsetY: CGFloat = height - convertedKeyboardFrame.minY
                if offsetY < 0 { return }

                self.view.transform = CGAffineTransform(translationX: 0, y: -offsetY)
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        })
    }
    
    @IBAction func didtapView(_ sender: UITapGestureRecognizer) {
        commentTextView.resignFirstResponder()
    }
    
    @IBAction func makeOffer(_ sender: UIButton) {
        loadingView = LoadingView(frame: self.view.bounds)
        self.view.addSubview(loadingView!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView!.alpha = 1
        }) { (complete) in
            /* send this offer to server */
            // here is just sample. remove after all.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
}


extension ConfirmOfferViewController: UITextViewDelegate {
}
