//
//  HistoryCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    static var identifier:String {
        get{
            return "HistoryCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "HistoryCell", bundle: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
