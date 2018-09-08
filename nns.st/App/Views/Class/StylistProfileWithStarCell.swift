//
//  StylistProfileWithStarCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class StylistProfileWithStarCell: UITableViewCell {
    
    static var identifier:String {
        get{
            return "StylistProfileWithStarCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "StylistProfileWithStarCell", bundle: nil)
        }
    }

    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var statusComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
