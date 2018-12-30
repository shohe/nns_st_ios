//
//  WaveView.swift
//  nns.st
//
//  Created by SHOHE on 2018/12/04.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

@IBDesignable
class WaveView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    override func draw(_ rect: CGRect) {
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 100, y: 300))
        line.addLine(to: CGPoint(x: 400, y: 900))
        line.close()
        UIColor.gray.setStroke()
        line.lineWidth = 3
        line.stroke()
    }
    
}

extension WaveView {
    private func initView() {
//        let contentView = Bundle.main.loadNibNamed("WaveView", owner: self, options: nil)?.first as! UIImageView
//        contentView.frame = self.bounds
//        addSubview(contentView)
    }
}
