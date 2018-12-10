//
//  NNSTableViewCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/12/09.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit


class NNSTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        localizedText()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func localizedText() {
        // localized text here.
    }

}
