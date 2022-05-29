//
//  UserServices.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation
protocol UserServiceable {
    func userLogin(username: String, password: String) async -> Result<Login, RequestError>
    func createUser(newUser: [String:String]?) async -> Result<Login, RequestError>
    func updateUser(id:Int,updateUser: [String:String]?,token:String) async -> Result<User, RequestError>
}

struct UserService: HTTPClient, UserServiceable {
   
    
    func userLogin(username: String, password: String)async -> Result<Login, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.login(username: username, password: password), responseModel: Login.self)
    }
    
    func createUser(newUser: [String:String]?) async -> Result<Login, RequestError>{
        return await sendRequest(endpoint: UserEndpoint.create(newUser: newUser), responseModel:Login.self)
    }
    func updateUser(id:Int,updateUser: [String:String]?,token:String) async -> Result<User, RequestError>{
        return await sendRequest(endpoint: UserEndpoint.update(id: id, newUser: updateUser, token: token), responseModel: User.self)
    }
}