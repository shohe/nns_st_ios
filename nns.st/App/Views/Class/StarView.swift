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
    @IBInspectable var resource: UIImage = UIImage() {
        didSet {
            self.initStars()
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
        addSubview(contentView)
    }
    
    private func initStars() {
        self.stars = [firstStar, secondStar, thirdStar, fourthStar, fifthStar]
        for star in stars {
            star.image = resource
        }
    }
    
}
