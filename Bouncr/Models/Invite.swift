//
//  Invite.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/3/22.
//

import Foundation

struct Invite: Codable,JSONCreatable {
    let id: Int
    //key of user invited
    let user_id: Int
    //key to event that the user is invited to
    let event_id: Int
    //time that user checked in, nil of user has not checked in
    let checkinTime: Date?
    //flag to indicate if user accepted invite
    let inviteStatus: Bool
    let coverChargePaid: Double
    let event: Event?
    let user: User?
    
    func toDict() -> [String:String]? {
        var newInvite:[String:String]? = [
                "user_id": String(user_id),
                "event_id": String(event_id),
                "inviteStatus": String(inviteStatus),
                "coverChargePaid": String(coverChargePaid)
            ]
        if let checkinTime = checkinTime {
            newInvite?.updateValue(DateFormatter.iso8601Full.string(from:checkinTime), forKey: "checkinTime")
        }
        return newInvite
    }
    
    
}
