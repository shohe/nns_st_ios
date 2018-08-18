//
//  BottomSheetViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var tableView: UITableView!
    
    static func instantiateViewController() -> BottomSheetViewController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareBackgroundView()
        self.configureObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initBottomSheet()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension BottomSheetViewController {
    
    func prepareBackgroundView() {
        let blurEffect = UIBlurEffect.init(style: .extraLight)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.alpha = 0.8
        bluredView.contentView.addSubview(visualEffect)
        
        let radius = view.layer.cornerRadius
        visualEffect.frame = UIScreen.main.bounds
        visualEffect.contentView.layer.cornerRadius = radius
        bluredView.frame = UIScreen.main.bounds
        bluredView.contentView.layer.cornerRadius = radius

        view.insertSubview(bluredView, at: 0)
    }
    
    func initBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let componentY = UIScreen.main.bounds.height - 200
            self.view.frame = CGRect(x: 0, y: componentY, width: frame.width, height: frame.height)
        }
    }
    
    func initTableView() {
        tableView = UITableView()
        tableView.frame = CGRect(x: 0.0, y: searchBar.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - searchBar.frame.size.height)
        tableView.alpha = 0.5
        tableView.tag = 99
    }
    
    func showTableView() {
        self.view.addSubview(tableView)
    }
    
    func hideTableView() {
        if let vtag = self.view.viewWithTag(99) {
            vtag.removeFromSuperview()
        }
    }
    
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
                let offsetY: CGFloat = self.searchBar!.frame.maxY - convertedKeyboardFrame.minY
                if offsetY < 0 { return }
                self.view.transform = CGAffineTransform(translationX: 0, y: -offsetY)
                self.showTableView()
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
            self.hideTableView()
        })
    }
    
}



extension BottomSheetViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
