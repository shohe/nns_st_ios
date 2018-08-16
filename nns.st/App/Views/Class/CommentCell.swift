//
//  CommentCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    static var identifier:String {
        get{
            return "CommentCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "CommentCell", bundle: nil)
        }
    }
    
    static var height:CGFloat {
        get{
            // deppends on size of comment label height
            return 100.0
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
