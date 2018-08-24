//
//  MypageMailAddressCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/24.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MypageMailAddressCell: UITableViewCell {
    
    @IBOutlet weak var mailAddress: UITextField!
    
    
    static var identifier:String {
        get{
            return "MypageMailAddressCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "MypageMailAddressCell", bundle: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.mailAddress.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


// MARK: - UITextFieldDelegate
extension MypageMailAddressCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
