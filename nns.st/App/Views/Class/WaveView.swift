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
    
}

extension WaveView {
    private func initView() {
//        let contentView = Bundle.main.loadNibNamed("WaveView", owner: self, options: nil)?.first as! UIImageView
//        contentView.frame = self.bounds
//        addSubview(contentView)
    }
}
