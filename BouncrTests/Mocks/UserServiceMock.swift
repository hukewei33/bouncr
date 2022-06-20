//
//  UserServiceMock.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation
@testable import Bouncr


final class UserServiceMock: Mockable, UserServiceable {
    func createUser(newUser: [String : String]?) async -> Result<User, RequestError> {
        return .success(loadJSON(filename: "ReturnUser", type: User.self))
    }
    
    func updateUser(id: Int, updateUser: [String : String]?, token: String) async -> Result<User, RequestError> {
        return .success(loadJSON(filename: "ReturnUser", type: User.self))
    }
    
    
    func userLogin(username: String, password: String) async -> Result<User, RequestError> {
        return .success(loadJSON(filename: "ReturnUser", type: User.self))
    }
    
    
}
