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
    
    class func emailExistRequest(email: String, handler: @escaping (String?) -> Void){
        Session.send(API.EmailExistRequest(email: email)) { result in
            switch result {
            case .success(let response):
                handler(response.email)
            case .failure(let error):
                handler(error.localizedDescription)
            }
        }
    }
}

/// DecodableDataParser
final class DecodableDataParser: DataParser {
    
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
    
}
