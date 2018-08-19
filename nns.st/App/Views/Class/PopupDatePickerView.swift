//
//  PopupDatePickerView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/19.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class PopupDatePickerView: UIView {

    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed("PopupDatePickerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
