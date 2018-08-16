//
//  CommentCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var comment: UILabel!
    
    static let commentLeftConst: CGFloat = 32.0
    static let commentRightConst: CGFloat = 24.0
    
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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
