//
//  NNSRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/10.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit


protocol NNSRequest: Request {
}

extension NNSRequest {
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
}

extension NNSRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
}





/// test
struct TestResponse: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title = "title"
        case completed
    }
}
