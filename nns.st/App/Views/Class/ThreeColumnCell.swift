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
    @IBOutlet weak var auraBottom: UIImageView!
    @IBOutlet weak var auraMiddle: UIImageView!
    @IBOutlet weak var auraTop: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initThumbnail()
    }
    
}


// MARK: - private
extension ThreeColumnCell {
    
    private func initThumbnail() {
        let sideMargin: CGFloat = 32 * 2
        thumbnailView.layer.cornerRadius = (self.frame.width - sideMargin) / 4
    }
    
    private func setAnim(view: UIView, duration: CFTimeInterval, isRightRotation: Bool) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = isRightRotation ? Double.pi * 2 : Double.pi * -2
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = .infinity
        view.layer.add(rotationAnimation, forKey: nil)
    }
    
}


// MARK: - public
extension ThreeColumnCell {
    
    func startAuraAnimation() {
        setAnim(view: auraBottom, duration: 14.0, isRightRotation: true)
        setAnim(view: auraMiddle, duration: 16.0, isRightRotation: false)
        setAnim(view: auraTop, duration: 12.0, isRightRotation: true)
    }
    
}
