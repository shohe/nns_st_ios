//
//  Review.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct Review: Decodable {

    let id: Int
    let dealUserId: Int
    let star: Int
    let comment: String?
    let writeUserId: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case dealUserId = "dealUserId"
        case star = "star"
        case comment = "comment"
        case writeUserId = "writeUserId"
    }
}
