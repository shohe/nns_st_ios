//
//  ThreeColumnCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/14.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ThreeColumnCell: UICollectionViewCell {
    
    static var identifier:String {
        get{
            return "ThreeColumnCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "ThreeColumnCell", bundle: nil)
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
