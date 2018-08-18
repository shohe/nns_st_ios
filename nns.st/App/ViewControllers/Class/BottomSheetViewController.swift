//
//  BottomSheetViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var km: UILabel!
    
    var tableView: UITableView!
    var matchingItems:[MKMapItem] = []
    var mapview: MKMapView? = nil
    
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
        // UI
        tableView = UITableView()
        tableView.frame = CGRect(x: 0.0, y: searchBar.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - searchBar.frame.size.height)
        tableView.backgroundColor = .clear
        
        // data
        tableView.tag = 99
        tableView.dataSource = self
        
        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(SearchResultCell.nib, forCellReuseIdentifier: SearchResultCell.identifier)
    }
    
    func resizeTable(height: CGFloat) {
        tableView.frame = CGRect(x: 0.0, y: searchBar.frame.size.height, width: self.view.frame.size.width, height: height)
    }
    
    func showTableView() {
        distanceLabel.isHidden = true
        slider.isHidden = true
        km.isHidden = true
        self.view.addSubview(tableView)
    }
    
    func hideTableView() {
        distanceLabel.isHidden = false
        slider.isHidden = false
        km.isHidden = false
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
                // let offsetY: CGFloat = self.searchBar!.frame.maxY - convertedKeyboardFrame.minY
                let offsetY: CGFloat = self.view.frame.height/2 - convertedKeyboardFrame.minY
                if offsetY < 0 { return }
                self.view.transform = CGAffineTransform(translationX: 0, y: -offsetY)
                tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: keyboardFrame.size.height + searchBar.frame.size.height, right: 0)
                self.showTableView()
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
            self.hideTableView()
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        })
    }
    
}



extension BottomSheetViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let mapView = mapview, let searchBarText = searchBar.text else { return true }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
        return true
    }
    
}



extension BottomSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell

        let selectedItem = matchingItems[indexPath.row].placemark
        cell.name.text = selectedItem.name
        cell.address.text = selectedItem.name
        return cell
    }
    
}
