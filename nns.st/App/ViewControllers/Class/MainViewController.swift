//
//  MainViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/14.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MainViewController: GradationViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var donationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBInspectable var itemWidth: CGFloat = 0.0
    
    private var items: [OfferRequireMatchedItem] = []
    
    
    static func instantiateViewController() -> MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! MainViewController
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout = collectionView.collectionViewLayout as! CarouselFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: collectionView.frame.size.height)
        
        let inset = (UIScreen.main.bounds.width - itemWidth) / 2.0
        layout.sectionInset = UIEdgeInsetsMake(0.0, inset, 0.0, inset)
        
        self.collectionView.reloadData()
        
        if NNSCore.userInfo().userType == UserType.Stylist {
            print("---")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ThreeColumnCell.nib, forCellWithReuseIdentifier: ThreeColumnCell.identifier)
        fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func localizedText() {
        leftLabel.text = NSLocalizedString("history", comment: "")
        middleLabel.text = NSLocalizedString("offer", comment: "")
        rightLabel.text = NSLocalizedString("review", comment: "")
        donationLabel.text = NSLocalizedString("sumOfDonation", comment: "")
        priceLabel.text = String(format: NSLocalizedString("currency", comment: ""), 0.0)
    }

}


// MARK: - private
extension MainViewController {
    
    private func fetch() {
        API.offerRequireMatchedRequest { (result) in
            if let res = result {
                for var item in res.located {
                    item.isNominated = false
                    self.items.append(item)
                }
                for var item in res.nominated {
                    item.isNominated = true
                    self.items.append(item)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setEdward(cell: ThreeColumnCell) {
        switch NNSCore.userInfo().userStatus {
        case .None:
            cell.nameLabel.isHidden = true
            cell.thumbnailView.image = UIImage(named: "edword_normal")
        case .Requested:
            cell.nameLabel.isHidden = false
            cell.nameLabel.text = NSLocalizedString("loadingStylistMessage", comment: "")
            cell.startAuraAnimation()
            cell.thumbnailView.image = UIImage(named: "edword_normal")
        case .Reserved:
            cell.nameLabel.isHidden = false
            cell.nameLabel.text = String(format: NSLocalizedString("waitingStylistMessage", comment: ""), 5)
            cell.thumbnailView.image = UIImage(named: "edword_waiting")
        case .Serviced:
            break
        }
    }
    
}


// MARK: - IBAction
extension MainViewController {
    
    @IBAction func pressCenterBtn(_ sender: UIButton) {
        switch NNSCore.userInfo().userStatus {
            case .None, .Serviced:
                self.present(MakeOfferViewController.instantiateViewController(parent: self), animated: true, completion: nil)
            case .Requested, .Reserved:
                if let offerId = NNSCore.userInfo().offerId {
                    self.present(HistoryInfoViewController.instantiateNavigationController(offerId: offerId), animated: true, completion: nil)
                }
        }
    }
    
    @IBAction func pressLeftBtn(_ sender: UIButton) {
        self.present(HistoryListViewController.instantiateViewController(parent: self), animated: true, completion: nil)
    }
    
    @IBAction func pressRightBtn(_ sender: UIButton) {
        self.present(MyReviewViewController.instantiateViewController(), animated: true, completion: nil)
    }
    
}


// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.present(MyPageViewController.instantiateViewController(), animated: true, completion: nil)
        } else {
            let item = items[indexPath.row-1] // -1 for mypage
            self.present(ConfirmRequestViewController.instantiateViewController(request: item, parent: self), animated: true, completion: nil)
        }
    }
    
}


// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1 // +1 for mypage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeColumnCell.identifier, for: indexPath) as! ThreeColumnCell
        
        if indexPath.row == 0 {
            setEdward(cell: cell)
        } else {
            let item = items[indexPath.row-1]
            cell.nameLabel.isHidden = false
            cell.nameLabel.text = item.name
            
            if item.isNominated! { cell.nameLabel.textColor = .yellow }
            
            if let url = item.imageUrl {
                cell.thumbnailView.loadImage(urlString: url)
            }
        }
        
        return cell
    }
    
}


// MARK: - ConfirmRequestViewControllerDelegate
extension MainViewController: ConfirmRequestViewControllerDelegate {
    
    func confirmRequestView(_ didMakeReservation: Bool) {
        if didMakeReservation {
            let info = NNSCore.userInfo()
            info.userStatus = .Reserved
            NNSCore.setUserInfo(userInfo: info)
        }
        
        // reset layout
        let layout:CarouselFlowLayout = self.collectionView.collectionViewLayout as! CarouselFlowLayout
        layout.sideItemScale = 1.0
        layout.sideItemAlpha = 1.0
        
        self.fetch()
    }
    
}


extension MainViewController: ConfirmOfferViewControllerDelegate {
    
    func confirmOfferViewController(_ didCreateOffer: Offer) {
        let info = NNSCore.userInfo()
        info.offerId = didCreateOffer.id
        info.dealUserId = didCreateOffer.stylistId
        info.userStatus = .Requested
        NNSCore.setUserInfo(userInfo: info)
    }
    
}
