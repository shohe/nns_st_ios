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
    
    /** return EmailExistResponse
     *   API.emailExistRequest(email: "shohe@gmail.com") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func emailExistRequest(email: String, handler: @escaping (EmailExistResponse?) -> Void){
        Session.send(API.EmailExistRequest(email: email)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userRegistRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return PasswordConfirmResponse
     *   API.passwordConfirmRequest(password: "password1234", c_password: "password1234") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func passwordConfirmRequest(password: String, c_password: String, handler: @escaping (PasswordConfirmResponse?) -> Void){
        Session.send(API.PasswordConfirmRequest(password: password, c_password: c_password)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userRegistRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return UserRegistResponse
     *   API.userRegistRequest(name: "test5", email: "test5@gmail.com", password: "testtest") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func userRegistRequest(name: String, email: String, password: String, handler: @escaping (UserRegistResponse?) -> Void){
        Session.send(API.UserRegistRequest(name: name, email: email, password: password)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userRegistRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return LoginResponse
     *   API.loginRequest(email: "test5@gmail.com", password: "testtest") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func loginRequest(email: String, password: String, handler: @escaping (LoginResponse?) -> Void){
        Session.send(API.LoginRequest(email: email, password: password)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userRegistRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return UserUpdateResponse
     *   API.userUpdateRequest(user: user, token: NNSCore.authToken()) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func userUpdateRequest(user: User?, handler: @escaping (UserUpdateResponse?) -> Void){
        Session.send(API.UserUpdateRequest(user: user)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userRegistRequest -> \(error)")
                handler(nil)
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
