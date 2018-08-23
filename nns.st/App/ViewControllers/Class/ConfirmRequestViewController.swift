//
//  ConfirmRequestViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit


class ConfirmRequestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Confirm", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CRNavigationController") as! UINavigationController
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(StylistProfileWithStarCell.nib, forCellReuseIdentifier: StylistProfileWithStarCell.identifier)
        tableView.register(PriceButtonCell.nib, forCellReuseIdentifier: PriceButtonCell.identifier)
        tableView.register(SalonAddressCell.nib, forCellReuseIdentifier: SalonAddressCell.identifier)
        tableView.register(CommentCell.nib, forCellReuseIdentifier: CommentCell.identifier)
        tableView.register(ReviewCell.nib, forCellReuseIdentifier: ReviewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - IBAction
extension ConfirmRequestViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - private function
extension ConfirmRequestViewController {
    
    private func addBottomSpaceView() {
        for view in self.tableView.subviews {
            if view.tag == 99 {
                view.removeFromSuperview()
            }
        }
        
        let origin: CGPoint = CGPoint(x: 0, y: tableView.contentSize.height)
        let size: CGSize = self.view.frame.size
        let view = UIView(frame: CGRect(origin: origin, size: size))
        view.backgroundColor = .white
        view.tag = 99
        self.tableView.addSubview(view)
    }
    
}


// MARK: - UITableViewDelegate
extension ConfirmRequestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.addBottomSpaceView()
    }
    
}


// MARK: - UITableViewDataSource
extension ConfirmRequestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StylistProfileWithStarCell.identifier, for: indexPath) as? StylistProfileWithStarCell {
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PriceButtonCell.identifier, for: indexPath) as? PriceButtonCell {
                cell.selectionStyle = .none
                cell.delegate = self as PriceButtonCellDelegate
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SalonAddressCell.identifier, for: indexPath) as? SalonAddressCell {
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.908887, longitude: 139.482338)
                SnapShotMaker.drawSnapshot(coordinate: coordinate, source: cell.mapSnap, pinColor: cell.pinColor)
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
                return cell
            }
        
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell {
                if indexPath.row != 4 {
                    cell.nonTitle()
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - PriceButtonCellDelegate
extension ConfirmRequestViewController: PriceButtonCellDelegate {
    
    func priceButtonCell(_ didSelectedButton: PriceButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
