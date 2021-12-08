//
//  Invite.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase


struct Invite {

    let ref: DatabaseReference?
    let key: String
    //key of user invited
    let userKey: String
    //key to event that the user is invited to
    let eventKey: String
    //time that user checked in, nil of user has not checked in
    let checkinTime: Double?
    //flag to indicate if user accepted invite
    var inviteStatus: Bool
    //flag to indicate if user checked into event
    var checkinStatus: Bool

    init(userKey: String, eventKey: String,  key: String = "") {
        self.ref = nil
        self.key = key
        self.userKey = userKey
        self.eventKey = eventKey
        self.checkinTime = nil
        self.inviteStatus = false
        self.checkinStatus = false
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let eventKey = value["eventKey"] as? String,
            let userKey = value["userKey"] as? String,
            let inviteStatus = value["inviteStatus"] as? Bool,
            let checkinStatus = value["checkinStatus"] as? Bool
        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.userKey = userKey
        self.eventKey = eventKey
        self.checkinTime = value["checkinTime"] as? Double
        self.inviteStatus = inviteStatus
        self.checkinStatus = checkinStatus
    }

    func toAnyObject() -> Any {
        return [
            "userKey": userKey,
            "eventKey": eventKey,
            "checkinTime": checkinTime,
            "inviteStatus": inviteStatus,
            "checkinStatus": checkinStatus
        ]
    }
}
