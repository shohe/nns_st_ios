//
//  OfferHistoryDetailGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OfferHistoryDetailGetResponse: Decodable{
    
    let item: OfferHistoryDetailGetItem?
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct OfferHistoryDetailGetItem: Decodable{
    
    let id: Int
    let name: String
    let imageUrl: String?
    let statusComment: String?
    let menu: String
    let price: Float
    let dateTime: String
    let hairType: HairType.RawValue
    let comment: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageUrl = "imageUrl"
        case statusComment = "statusComment"
        case menu = "menu"
        case price = "price"
        case dateTime = "dateTime"
        case hairType = "hairType"
        case comment = "comment"
    }
}
