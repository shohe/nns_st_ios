//
//  CharityCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/23.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

protocol CharityCellDelegate {
    func charityCell(cell: CharityCell, _didSelectedCharity sender: UIButton)
}

class CharityCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var charityImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var delegate: CharityCellDelegate? = nil
    var charityId: Int?
    
    
    static var identifier:String {
        get{
            return "CharityCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "CharityCell", bundle: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.leftSideCornerRadius(view: charityImageView)
        self.rightDownSideCornerRadius(button: selectButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension CharityCell {
    
    private func leftSideCornerRadius(view: UIImageView) -> Void {
        // To fill in some space -> I don't know why it makes some space on right side.
        var _bounds = view.bounds
        _bounds.size.width += 13.5
        view.bounds = _bounds
        
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 5, height: 5))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    private func rightDownSideCornerRadius(button: UIButton) -> Void {
        // To fill in some space -> I don't know why it makes some space on right side.
        var _bounds = button.bounds
        _bounds.size.width += 15.0
        button.bounds = _bounds
        
        let maskPath = UIBezierPath(roundedRect: button.bounds, byRoundingCorners: [.bottomRight],cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = button.bounds
        maskLayer.path = maskPath.cgPath
        button.layer.mask = maskLayer
    }
    
}


extension CharityCell {
    
    @IBAction func selectCharity(_ sender: UIButton) {
        self.delegate?.charityCell(cell: self, _didSelectedCharity: selectButton)
    }
    
}

