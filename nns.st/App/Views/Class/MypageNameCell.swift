//
//  MypageNameCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/24.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MypageNameCell: UITableViewCell {

    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    
    static var identifier:String {
        get{
            return "MypageNameCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "MypageNameCell", bundle: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lastName.delegate = self
        self.firstName.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


// MARK: - UITextFieldDelegate
extension MypageNameCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == lastName {
            firstName.becomeFirstResponder()
        } else {
            lastName.resignFirstResponder()
            firstName.resignFirstResponder()
        }
        return true
    }
    
}
