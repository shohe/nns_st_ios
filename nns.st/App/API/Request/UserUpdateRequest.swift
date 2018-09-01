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
            if let image_url = user.imageUrl { jsonResouce["imageUrl"] = image_url }
            if let status_comment = user.statusComment { jsonResouce["statusComment"] = status_comment }
            if let is_stylist = user.isStylist { jsonResouce["isStylist"] = is_stylist }
            if let salon_name = user.salonName { jsonResouce["salonName"] = salon_name }
            if let salon_address = user.salonAddress { jsonResouce["salonAddress"] = salon_address }
            if let salon_location_lat = user.salonLocationLat { jsonResouce["salonLocationLat"] = salon_location_lat }
            if let salon_location_lng = user.salonLocationLng { jsonResouce["salonLocationLng"] = salon_location_lng }
            
            return JSONBodyParameters(JSONObject: jsonResouce)
        }
    }
}
