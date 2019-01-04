//
//  OfferHistoryListGetRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct OfferHistoryListGetRequest: NNSRequest {
        typealias Response = OfferHistoryListGetResponse
        let method: HTTPMethod = .get
        let isStylist: Int
        var path: String { return "/api/offerHistoryList/\(isStylist)" }
    }
}
