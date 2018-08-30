//
//  ReviewAverageCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ReviewAverageCell: UITableViewCell {
    
    static var identifier:String {
        get{
            return "ReviewAverageCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "ReviewAverageCell", bundle: nil)
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
