//
//  LoadingView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class LoadingView: BackgroundView {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var auraBottom: UIImageView!
    @IBOutlet weak var auraMiddle: UIImageView!
    @IBOutlet weak var auraTop: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

}



extension LoadingView {
    
    private func initView() {
        let contentView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        self.alpha = 0
        addSubview(contentView)
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


extension LoadingView {
    
    func setComment(text: String?) {
        commentLabel.text = text
    }
    
    func startAuraAnimation() {
        setAnim(view: auraBottom, duration: 14.0, isRightRotation: true)
        setAnim(view: auraMiddle, duration: 16.0, isRightRotation: false)
        setAnim(view: auraTop, duration: 12.0, isRightRotation: true)
    }
    
}
