//
//  PriceButtonCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class PriceButtonCell: UITableViewCell {
    
    @IBOutlet weak var priceButton: UIButton!
    
    static var identifier:String {
        get{
            return "PriceButtonCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "PriceButtonCell", bundle: nil)
        }
    }
    
    static var height:CGFloat {
        get{
            return 90.0
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
