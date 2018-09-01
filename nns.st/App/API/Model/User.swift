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
    var is_stylist: Bool?
    var salon_name: String?
    var salon_address: String?
    var salon_location_lat: Double?
    var salon_location_lng: Double?
    var salon_location: SalonLocation?

    init() {}

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case password = "password"
        case image_url = "image_url"
        case status_comment = "status_comment"
        case is_stylist = "is_stylist"
        case salon_name = "salon_name"
        case salon_address = "salon_address"
        case salon_location_lat = "salon_location_lat"
        case salon_location_lng = "salon_location_lng"
        case salon_location = "salon_location"
    }
}

struct SalonLocation: Decodable {
    let lat: Double
    let lng: Double
    
    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}
