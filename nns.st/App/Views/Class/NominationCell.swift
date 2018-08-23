//
//  NominationCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/22.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class NominationCell: UITableViewCell {
    
    @IBOutlet weak var stylistImage: UIImageView!
    @IBOutlet weak var stylistName: UILabel!
    
    static var identifier:String {
        get{
            return "NominationCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "NominationCell", bundle: nil)
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


extension NominationCell {
    
    func setEachValue(item: OfferItem?) {
        if let item = item {
            // todo
        }
    }
    
}
