//
//  Host.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase

struct Host {

    let ref: DatabaseReference?
    let key: String
    //user key of host
    let userKey: String
    //userkey of event
    let eventKey: String


    init(userKey: String,eventKey: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.userKey = userKey
        self.eventKey = eventKey

    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let eventKey = value["eventKey"] as? String,
            let userKey = value["userKey"] as? String

        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.userKey = userKey
        self.eventKey = eventKey

    }

    func toAnyObject() -> Any {
        return [
            "userKey": userKey,
            "eventKey": eventKey,
        ]
    }
}
//struct Host {
//
//    let ref: DatabaseReference?
//    let key: String
//    //user key of host
//    let userKey: String
//    //userkey of event
//    let eventKey: String
//
//
//    init(userKey: String,eventKey: String, key: String = "") {
//        self.ref = nil
//        self.key = key
//        self.userKey = userKey
//        self.eventKey = eventKey
//
//    }
//
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let eventKey = value["eventKey"] as? String,
//            let userKey = value["userKey"] as? String
//
//        else {
//            return nil
//        }
//
//        self.ref = snapshot.ref
//        self.key = snapshot.key
//        self.userKey = userKey
//        self.eventKey = eventKey
//
//    }
//
//    func toAnyObject() -> Any {
//        return [
//            "userKey": userKey,
//            "eventKey": eventKey,
//        ]
//    }
//}
