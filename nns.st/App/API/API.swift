//
//  API.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

//import Alamofire
//import BrightFutures

/// NNSAPI
final class API {
    
    private init() {}
    
    struct TestRequest: NNSRequest {
        typealias Response = TestResponse
        
        let method: HTTPMethod = .get
        var path: String {
            return "/todos/\(userId)"
        }
        let userId: Int
    }
}
