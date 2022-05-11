//
//  User.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation


struct User : Codable,JSONCreatable {

    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let phoneNumber: Int
    let birthday: Date
    let orgUser: [OrgUser]?
    let password: String?
    
    func toDict() -> [String:String]? {
        var newUser=[
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "username": username,
            "phoneNumber":String(phoneNumber),
            "birthday":DateFormatter.iso8601Full.string(from:birthday)
        ]
        if let pw = password{
            newUser.updateValue(pw, forKey: "password")
        }
        return newUser
    }

}


