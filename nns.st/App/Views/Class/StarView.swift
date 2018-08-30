//
//  StarView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: UIView {
    
    
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    
    @IBInspectable var resource: UIImage? = UIImage() {
        didSet {
            self.initStars()
        }
    }
    
    @IBInspectable var emptyResouce: UIImage? = UIImage() {
        didSet {
            self.initStars()
        }
    }
    
    //* plus number express from left side (default) *//
    //* minus number express from right side *//
    //* 1 digit: hidden white star *//
    //* 2 digit: shown white star *//
    //* ex)           ★★★★★
    //* -----------------------
    //* ex) 4 ->      ★★★★ -
    //* ex) 12 ->     ★★☆☆☆
    //* ex) -3 ->     - - ★★★
    //* ex) -14 ->    ☆★★★★
    
    @IBInspectable var count: Int = 5 {
        didSet {
            self.initCount()
        }
    }
    
    private var stars: [UIImageView] = []
    
    
    //* height:width = 1:5.5 is the best rate *//
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

}


// MARK: - private
extension StarView {
    
    private func initView() {
        let contentView = Bundle.main.loadNibNamed("StarView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        self.stars = [firstStar, secondStar, thirdStar, fourthStar, fifthStar]
        addSubview(contentView)
    }
    
    private func initStars() {
        for star in stars {
            star.image = resource
            star.highlightedImage = emptyResouce
        }
    }
    
    private func initCount() {
        if self.count > 0 { //* count from left side *//

            for i in 0..<5 {
                let count = (self.count > 10) ? self.count - 10 : self.count
                if self.emptyResouce != nil {
                    if self.count > 10 {
                        self.stars[i].isHighlighted = (i < count) ? false : true
                    } else {
                        self.stars[i].isHidden = (i < count) ? false : true
                    }
                } else {
                    self.stars[i].alpha = (i < count) ? 1 : (self.count > 10) ? 0.2 : 0
                }
            }
            
        } else { //* count from right side *//
            self.count *= -1
            for i in (0..<5).reversed() {
                let count = (self.count > 10) ? self.count - 11 : self.count - 1
                if self.emptyResouce != nil {
                    if self.count > 10 {
                        self.stars[i].isHighlighted = (i >= count) ? false : true
                    } else {
                        self.stars[i].isHidden = (i >= count) ? false : true
                    }
                } else {
                    self.stars[i].alpha = (i >= count) ? 1 : (self.count > 10) ? 0.2 : 0
                }
            }
            
        }
    }
    
}
