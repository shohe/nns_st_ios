//
//  User.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct User: Decodable {
    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var image_url: String?
    var status_comment: String?
    var is_stylist: Bool = false
    var salon_name: String?
    var salon_address: String?
    var salon_location_lat: Double?
    var salon_location_lng: Double?
}
