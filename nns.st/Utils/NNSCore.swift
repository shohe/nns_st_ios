//
//  NNSCore.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

enum NNSDataKey: String {
    case authToken = "AuthToken"
}

class NNSCore {
    class func authToken() -> String? {
        return UserDefaults.standard.string(forKey: NNSDataKey.authToken.rawValue)
    }
    
    class func setAuthToken(_ token: String?) {
        if token == nil {return}
        UserDefaults.standard.set(token!, forKey: NNSDataKey.authToken.rawValue)
        UserDefaults.standard.synchronize()
    }
}
