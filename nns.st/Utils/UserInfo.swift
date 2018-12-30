//
//  UserInfo.swift
//  nns.st
//
//  Created by SHOHE on 2018/12/01.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

class UserInfo: NSObject, NSCoding {
    static let key = "UserInfo"
    
    var authToken: String? = nil
    var userStatus: UserStatus = UserStatus.None
    var userType: UserType = UserType.Customer
    var userMode: UserType = UserType.Customer
    var offerId: Int? = nil
    var dealUserId: Int? = nil
    
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        self.authToken = aDecoder.decodeObject(forKey: "authToken") as? String
        self.offerId = aDecoder.decodeObject(forKey: "offerId") as? Int
        self.dealUserId = aDecoder.decodeObject(forKey: "dealUserId") as? Int
        
        if let status = aDecoder.decodeObject(forKey: "userStatus") as? String {
            self.userStatus = UserStatus(rawValue: status) ?? UserStatus.None
        } else {
            self.userStatus = UserStatus.None
        }

        self.userType = UserType(rawValue: aDecoder.decodeInteger(forKey: "userType")) ?? UserType.Customer
        self.userMode = UserType(rawValue: aDecoder.decodeInteger(forKey: "userMode")) ?? UserType.Customer
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.authToken, forKey: "authToken")
        aCoder.encode(self.offerId, forKey: "offerId")
        aCoder.encode(self.dealUserId, forKey: "dealUserId")
        aCoder.encode(self.userStatus.rawValue, forKey: "userStatus")
        aCoder.encode(self.userType.rawValue, forKey: "userType")
        aCoder.encode(self.userMode.rawValue, forKey: "userMode")
    }
}
