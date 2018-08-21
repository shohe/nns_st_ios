//
//  HairTypeInfoCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class HairTypeInfoCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    
    static var identifier:String {
        get{
            return "HairTypeInfoCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "HairTypeInfoCell", bundle: nil)
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


extension HairTypeInfoCell {
    
    func setEachValue(item: OfferItem?) {
        if let item = item {
            setTitle(type: item.hairType)
            setImage(type: item.hairType)
        }
    }
    
    private func setTitle(type: HairType?) {
        if let type = type {
            title.text = type.title()
        }
    }
    
    private func setImage(type: HairType?) {
        if let type = type {
            typeImage.image = type.image()
        }
    }
    
}
