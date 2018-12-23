//
//  ThreeColumnCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/14.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ThreeColumnCell: UICollectionViewCell {
    
    static var identifier:String {
        get{
            return "ThreeColumnCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "ThreeColumnCell", bundle: nil)
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var auraTop: WaveEdgeView!
    @IBOutlet weak var auraMiddle: WaveEdgeView!
    @IBOutlet weak var auraBottom: WaveEdgeView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initThumbnail()
    }
    
    override func prepareForReuse() {
        self.hideAura()
    }
    
}


// MARK: - private
extension ThreeColumnCell {
    
    private func initThumbnail() {
        let sideMargin: CGFloat = 32 * 2
        thumbnailView.layer.cornerRadius = (self.frame.width - sideMargin) / 4
    }
    
}


// MARK: - public
extension ThreeColumnCell {
    
    func showAura() {
        auraBottom.isHidden = false
        auraMiddle.isHidden = false
        auraTop.isHidden = false
    }
    
    func hideAura() {
        auraBottom.isHidden = true
        auraMiddle.isHidden = true
        auraTop.isHidden = true
    }
    
}
