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

    
    @IBInspectable var pinColor: UIColor = UIColor.red
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension SalonAddressCell {
    
    func drawSnapshot(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Void {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpanMake(0.003, 0.003)
        
        let options = MKMapSnapshotOptions()
        options.size = self.mapSnap.frame.size
        options.region = MKCoordinateRegion(center: coordinate, span: span)
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start(completionHandler: {(snapshot, error) in
            if let snapshot = snapshot {
                self.mapSnap.image = self.dropPin(snapshot: snapshot, coordinate: coordinate)
            }
        })
    }
    
    private func dropPin(snapshot: MKMapSnapshot, coordinate: CLLocationCoordinate2D) -> UIImage {
        let annotationView = MKPinAnnotationView(annotation: nil, reuseIdentifier: "Pin")
        annotationView.pinTintColor = self.pinColor
        
        let pinImg = annotationView.image
        UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
        snapshot.image.draw(at: CGPoint(x: 0.0, y: 0.0))
        pinImg?.draw(at: self.centeringPoint(originPoint: snapshot.point(for: coordinate), annotation: annotationView))
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage!
    }
    
    private func centeringPoint(originPoint: CGPoint, annotation: MKPinAnnotationView) -> CGPoint {
        let pinCenterOffset = annotation.centerOffset
        var _originPoint = originPoint
        _originPoint.x -= annotation.bounds.size.width / 2.0
        _originPoint.y -= annotation.bounds.size.height / 2.0
        _originPoint.x += pinCenterOffset.x
        _originPoint.y += pinCenterOffset.y
        return _originPoint
    }
    
}
