//
//  UserEndpoint.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation

enum UserEndpoint {
    case login(username: String, password: String)
    case create(newUser:[String:String]?)
    case update(id:Int,newUser:[String:String]?,token: String)
    
}

extension UserEndpoint: Endpoint {
    var path: String {
        switch self {
        case .login(let username, let password):
            return "login?username=\(username)&password=\(password)"
        case .create(let dic):
            return "users"+DictToParamString().toParam(input: dic)
        case .update(let id,let dic,_):
            return "users/\(id)"+DictToParamString().toParam(input: dic)
        }
    }

    var method: RequestMethod {
        switch self {
        case .login:
            return .get
        case .create:
            return .post
        case .update:
            return .patch
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        //let accessToken = "Your TMDB Access Token here!!!!!!!"
        switch self {
        case .login, .create:
            return nil
        case .update(_, _,let accessToken):
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .login:
            return nil
        case .create(let newUser),.update(_ ,let newUser, _):
            return newUser

        }
    }
}
