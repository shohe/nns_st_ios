//
//  SalonAddressCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit

class SalonAddressCell: UITableViewCell {
    
    @IBOutlet weak var mapSnap: UIImageView!
    
    static var identifier:String {
        get{
            return "SalonAddressCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "SalonAddressCell", bundle: nil)
        }
    }
    
    static var height:CGFloat {
        get{
            return 150.0
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let coordinate = CLLocationCoordinate2DMake(35.908887, 139.482338)
        let span = MKCoordinateSpanMake(0.003, 0.003)
        
        let options = MKMapSnapshotOptions()
        options.size = CGSize(width: 152, height: 127)
        options.region = MKCoordinateRegion(center: coordinate, span: span)
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start(completionHandler: {(snapshot, error) in
            self.mapSnap.image = snapshot?.image
            self.mapSnap.clipsToBounds = true
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
