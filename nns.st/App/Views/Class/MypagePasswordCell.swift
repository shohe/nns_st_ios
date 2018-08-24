//
//  MypagePasswordCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/24.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MypagePasswordCell: UITableViewCell {
    
    @IBOutlet weak var passwordField: UITextField!
    
    static var identifier:String {
        get{
            return "MypagePasswordCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "MypagePasswordCell", bundle: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


// MARK: - UITextFieldDelegate
//extension MypagePasswordCell: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("--")
//        return true
//    }
//
//}
