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
        fetchRequests()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - private
extension MainViewController {
    
    private func fetchRequests() {
        API.requestGetRequest { (result) in
            if let res = result {
                self.requests = res.item
                self.collectionView.reloadData()
            }
        }
    }
    
}


// MARK: - IBAction
extension MainViewController {
    
    @IBAction func pressOfferBtn(_ sender: UIButton) {
        self.present(MakeOfferViewController.instantiateViewController(), animated: true, completion: nil)
    }
    
    @IBAction func pressHistoryBtn(_ sender: UIButton) {
        self.present(HistoryListViewController.instantiateViewController(), animated: true, completion: nil)
    }
    
    // will not use charity
    @IBAction func pressCharityBtn(_ sender: UIButton) {
        self.present(CharityListViewController.instantiateViewController(), animated: true, completion: nil)
    }
    
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
            self.present(ConfirmRequestViewController.instantiateViewController(), animated: true, completion: nil)
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
        return cell
    }
    
}
