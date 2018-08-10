//
//  API.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import UIKit

import Alamofire
import BrightFutures

class API {
    
    class func testCodeForAPI() -> Future<AnyObject, NSError> {
        let promise = Promise<AnyObject, NSError>()
        let queue = DispatchQueue(label: "testCodeForAPI", attributes: .concurrent)
        Alamofire.request("https://jsonplaceholder.typicode.com/todos/1").responseJSON(queue: queue) { (response) in
            switch response.result {
            case .success(let value):
                print("json : \(value)")
                promise.success(value as AnyObject)
            case .failure(let error):
                print("error : \(error)")
                promise.failure(error as NSError)
            }
        }
        return promise.future
    }
    
}

