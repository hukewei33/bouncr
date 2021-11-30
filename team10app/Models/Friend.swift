//
//  Friend.swift
//  team10app
//
//  Created by Kenny Hu on 11/8/21.
//
import Foundation
import Firebase

struct Friend {

    let ref: DatabaseReference?
    let key: String
    let userKey1: String
    let userKey2: String
    let twinKey : String
    let accepted : Bool


    init(userKey1: String,userKey2: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.userKey1 = userKey1
        self.userKey2 = userKey2
        self.twinKey = ""
        self.accepted = false
        

    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let userKey1 = value["userKey1"] as? String,
            let userKey2 = value["userKey2"] as? String,
            let twinKey = value["twinKey"] as? String,
            let accepted = value["accepted"] as? Bool

        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.userKey1 = userKey1
        self.userKey2 = userKey2
        self.twinKey = twinKey
        self.accepted = accepted

    }

    func toAnyObject() -> Any {
        return [
            "userKey1": userKey1,
            "userKey2": userKey2,
        ]
    }
}
