//
//  User.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase



struct User :Hashable, Decodable {

    let key: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let phoneNumber: Int

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.key == rhs.key
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    enum CodingKeys : String, CodingKey {
        case key = "id"
        case username = "username"
        case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
        case email = "email"
        
    }
    
    
    init(firstName: String, lastName: String, email: String, username: String, passwordHash: String, key: Int = -1, phoneNumber:Int) {
        self.key = key
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.phoneNumber = phoneNumber
    }
    
    init(key: String, at: UserAttributes){
        self.key=Int(key) ?? 0
        self.username = at.username
        self.phoneNumber=at.phoneNumber
        self.firstName=at.firstName
        self.lastName=at.lastName
        self.email=at.email
    }
    
    
    
    
    func toAnyObject() -> Any {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "username": username,
            "phoneNumber":phoneNumber
        ]
    }
}


