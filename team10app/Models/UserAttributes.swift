//
//  UserAttributes.swift
//  team10app
//
//  Created by Kenny Hu on 4/15/22.
//

import Foundation
struct UserAttributes :Decodable {

    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let phoneNumber: Int

    
    enum CodingKeys : String, CodingKey {

        case username = "username"
        case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
        case email = "email"
        
    }
    
    func makeUser(key: String)->User{
        return User(key: key, at: self)
    }
}
