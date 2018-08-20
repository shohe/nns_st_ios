//
//  OfferItem.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit

class OfferItem: NSObject {

    var menu: String?
    var price: CGFloat?
    var datetime: Date?
    var location: CLLocationCoordinate2D?
    var distance: CGFloat?
    var hairType: HairType?
    
    deinit { }
    
}

extension OfferItem {
    
    func checkAllValue() -> Bool {
        if menu == nil || menu == "" { return false }
        if price == nil { return false }
        if datetime == nil { return false }
        if location == nil { return false }
        if distance == nil { return false }
        if hairType == nil { return false }
        return true
    }
    
}
