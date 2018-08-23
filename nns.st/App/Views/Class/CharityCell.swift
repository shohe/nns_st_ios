//
//  CharityCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/23.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CharityCell: UITableViewCell {
    
    static var identifier:String {
        get{
            return "CharityCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "CharityCell", bundle: nil)
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
