//
//  NNSRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/10.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import APIKit

/// NNS API Error Domain
let NNSAPIRequestErrorDomain = "NNSRequestAPIErrorDomain"

/// NNS API Error Code
let NNSAPIRequestErrorCode = 9999

/// NNS API no response error code.
let NNSAPIRequestNoResponseErrorCode = 9998

/// NNS API no response error message.
let NNSAPIRequestNoResponseErrorMessage = NSLocalizedString("NNSNoResponseErrorMessage", tableName: "APIError", comment: "NNSNoResponseErrorMessage")

protocol NNSRequest: Request {
}

extension NNSRequest {
    
    var baseURL: NSURL {
        /// for real
        /// return NSURL(string: "https://nonamesalon.st/api")!
        /// for develop
        return NSURL(string: "https://nonamesalon.st/api")!
    }
    
    func responseFromObject(object: AnyObject, response: HTTPURLResponse?) -> Self.Response? {
        return nil
    }
    
    func errorFromObject(object: AnyObject, response: HTTPURLResponse?) -> NSError? {
        // this time api won't response with error.
        return noResponseError()
    }
    
    func noResponseError() -> NSError {
        return NSError(domain: NNSAPIRequestErrorDomain, code: NNSAPIRequestNoResponseErrorCode, userInfo: [NSLocalizedDescriptionKey: NNSAPIRequestNoResponseErrorMessage, NSLocalizedFailureErrorKey: NNSAPIRequestNoResponseErrorMessage])
    }
    
}
