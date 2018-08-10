//
//  DecodableDataParser.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/10.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

final class DecodeableDataParser: DataParser {
    
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
    
}
