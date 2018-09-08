//
//  UserImageUploadRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/08.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct UserImageUploadRequest: NNSRequest {
        typealias Response = UserImageUploadResponse
        let method: HTTPMethod = .post
        let image: UIImage
        var path: String { return "/api/user/image" }
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            params.append(try! MultipartFormDataBodyParameters.Part(value: image, name: "image"))
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}

