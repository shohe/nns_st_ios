//
//  CommentInfoCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CommentInfoCell: NNSTableViewCell {
    
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    static var identifier:String {
        get{
            return "CommentInfoCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "CommentInfoCell", bundle: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initTextView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func localizedText() {
        commentTitleLabel.text = NSLocalizedString("comment", comment: "")
    }
    
}


extension CommentInfoCell {
    
    func initTextView() {

    }
    
}
