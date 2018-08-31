//
//  UserUpdateRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct UserUpdateRequest: NNSRequest {
        typealias Response = UserUpdateResponse
        let method: HTTPMethod = .put
        let user: User?
        var path: String { return "/api/user" }
        
        var bodyParameters: BodyParameters? {
            guard let user = user else { return nil }
            var jsonResouce: [String: Any] = [:]
            
            if let name = user.name { jsonResouce["name"] = name }
            if let email = user.email { jsonResouce["email"] = email }
            if let password = user.password { jsonResouce["password"] = password }
            if let image_url = user.image_url { jsonResouce["image_url"] = image_url }
            if let status_comment = user.status_comment { jsonResouce["status_comment"] = status_comment }
            if let is_stylist = user.is_stylist { jsonResouce["is_stylist"] = is_stylist }
            if let salon_name = user.salon_name { jsonResouce["salon_name"] = salon_name }
            if let salon_address = user.salon_address { jsonResouce["salon_address"] = salon_address }
            if let salon_location_lat = user.salon_location_lat { jsonResouce["salon_location_lat"] = salon_location_lat }
            if let salon_location_lng = user.salon_location_lng { jsonResouce["salon_location_lng"] = salon_location_lng }
            
            return JSONBodyParameters(JSONObject: jsonResouce)
        }
    }
}
