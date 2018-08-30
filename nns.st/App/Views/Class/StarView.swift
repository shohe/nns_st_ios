//
//  StarView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class StarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        let contentView = Bundle.main.loadNibNamed("StarView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
    }

}
