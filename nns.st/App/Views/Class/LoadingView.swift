//
//  LoadingView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        let contentView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        self.alpha = 0
        addSubview(contentView)
    }

}
