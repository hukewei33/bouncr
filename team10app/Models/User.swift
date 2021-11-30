//
//  User.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase

struct User :Hashable {
    
    let ref: DatabaseReference?
    let key: String
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let profilePicURL: String?
    let passwordHash: String

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.key == rhs.key
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    
    init(firstName: String, lastName: String, email: String, username: String, profilePicURL : String?, passwordHash: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.profilePicURL = profilePicURL
        self.passwordHash = passwordHash
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let email = value["email"] as? String,
            let username = value["username"] as? String,
            let passwordHash = value["passwordHash"] as? String
        
        else {
            print("bad read: USER")
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.profilePicURL = value["profilePicURL"] as? String
        self.passwordHash = passwordHash
    }
    
    
    
    func toAnyObject() -> Any {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "username": username,
            "profilePicURL": profilePicURL,
            "passwordHash":passwordHash
        ]
    }
}

//struct User {
//
//    let ref: DatabaseReference?
//    let key: String
//    let firstName: String
//    let lastName: String
//    let email: String
//    let username: String
//    let profilePicURL: String?
//    let passwordHash: String
//
//
//    init(firstName: String, lastName: String, email: String, username: String, profilePicURL : String?, passwordHash: String = "", key: String = "") {
//        self.ref = nil
//        self.key = key
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.username = username
//        self.profilePicURL = profilePicURL
//        self.passwordHash = passwordHash
//    }
//
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let firstName = value["firstName"] as? String,
//            let lastName = value["lastName"] as? String,
//            let email = value["email"] as? String,
//            let username = value["username"] as? String,
//            let passwordHash = value["passwordHash"] as? String
//
//        else {
//            print("bad read")
//            return nil
//        }
//
//        self.ref = snapshot.ref
//        self.key = snapshot.key
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.username = username
//        self.profilePicURL = value["profilePicURL"] as? String
//        self.passwordHash = passwordHash
//    }
//
//
//
//    func toAnyObject() -> Any {
//        return [
//            "firstName": firstName,
//            "lastName": lastName,
//            "email": email,
//            "username": username,
//            "profilePicURL": profilePicURL,
//            "passwordHash":passwordHash
//        ]
//    }
//}
