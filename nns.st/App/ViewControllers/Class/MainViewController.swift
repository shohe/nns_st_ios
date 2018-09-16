//
//  MainViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/14.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBInspectable var itemWidth: CGFloat = 0.0
    
    private var requests: [RequestGetItem] = []
    
    
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

}


// MARK: - private
extension MainViewController {
    
    private func fetch() {
        if NNSCore.isWaitState() {
            self.fetchDayCount()
        } else if NNSCore.madeOfferId() > 0 {
            self.fetchRequests()
        }
    }
    
    private func fetchDayCount() {
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm:ss"

        API.dayCountRequest(today: "\(dateFormatter.string(from: date)) \(timeFormatter.string(from: date))") { (result) in
            if let res = result {
                // day count
                print("あと\(res.count)日")
                self.requests.removeAll()
                self.collectionView.reloadData()
            } else {
                // time to go to review
                print("レビュー画面に行く")
                NNSCore.setMadeOfferId(0)
                NNSCore.setWaitState(false)
            }
        }
    }
    
    private func fetchRequests() {
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm:ss"
        
        API.dayCountRequest(today: "\(dateFormatter.string(from: date)) \(timeFormatter.string(from: date))") { (result) in
            if let res = result {
                if res.count >= 0 {
                    // still offer is working
                    API.requestGetRequest { (result) in
                        if let res = result {
                            self.requests = res.item
                            self.collectionView.reloadData()
                        }
                    }
                } else {
                    // dead offer by date-time
                    self.setCloseDeadOffer()
                }
            } else {
                // dead offer by date-time
                self.setCloseDeadOffer()
            }
        }
    }
    
    private func setCloseDeadOffer() {
        API.offerCancelRequest(id: NNSCore.madeOfferId()) { (result) in
            if result != nil {
                NNSCore.setMadeOfferId(0)
                NNSCore.setWaitState(false)
                self.showAleart()
            }
        }
    }
    
    private func showAleart() {
        let title = "期限切れ"
        let message = "予定の日にちが過ぎたのでオファーは廃棄されます"
        let buttonTitle = "ok"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


// MARK: - IBAction
extension MainViewController {
    
    @IBAction func pressOfferBtn(_ sender: UIButton) {
        if NNSCore.madeOfferId() > 0 { // if user did make offer already...
            self.present(HistoryInfoViewController.instantiateNavigationController(offerId: NNSCore.madeOfferId()), animated: true, completion: nil)
        } else {
            self.present(MakeOfferViewController.instantiateViewController(parent: self), animated: true, completion: nil)
        }
    }
    
    @IBAction func pressHistoryBtn(_ sender: UIButton) {
        self.present(HistoryListViewController.instantiateViewController(parent: self), animated: true, completion: nil)
    }
    
//    // will not use charity
//    @IBAction func pressCharityBtn(_ sender: UIButton) {
//        self.present(CharityListViewController.instantiateViewController(), animated: true, completion: nil)
//    }
    
    @IBAction func pressMyReviewBtn(_ sender: UIButton) {
        self.present(MyReviewViewController.instantiateViewController(), animated: true, completion: nil)
    }
    
}


// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.present(MyPageViewController.instantiateViewController(), animated: true, completion: nil)
        } else {
            let item = requests[indexPath.row-1] // -1 for mypage
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
        return requests.count + 1 // +1 for mypage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeColumnCell.identifier, for: indexPath) as! ThreeColumnCell
        
        if indexPath.row == 0 {
            cell.nameLabel.isHidden = true
        } else {
            let item = requests[indexPath.row-1]
            cell.nameLabel.isHidden = false
            cell.nameLabel.text = item.name
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
        NNSCore.setWaitState(didMakeReservation)
        
        // reset layout
        let layout:CarouselFlowLayout = self.collectionView.collectionViewLayout as! CarouselFlowLayout
        layout.sideItemScale = 1.0
        layout.sideItemAlpha = 1.0
        
        self.fetch()
    }
    
}


extension MainViewController: ConfirmOfferViewControllerDelegate {
    
    func confirmOfferViewController(_ didCreateOffer: Offer) {
        NNSCore.setMadeOfferId(didCreateOffer.id!)
    }
    
}
