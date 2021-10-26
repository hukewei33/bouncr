//
//  Event.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase

struct Event {

    let ref: DatabaseReference?
    let key: String
    let name: String
    //start time of event in Date type casted as double
    let startTime: Double
    //end time of event in Date type casted as double
    let endTime: Double?
    //Address info
    let street1: String
    let street2: String?
    let city: String
    let state: String
    let zip: String
    let description: String?


    init(name: String, startTime: Date, street1: String, street2 : String? , city: String, state: String, zip: String, description: String?, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.startTime = startTime.timeIntervalSinceReferenceDate
        self.endTime = nil
        self.street1 = street1
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
        self.description = description
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"]as? String,
            let startTime = value["startTime"]as? Double,
            let street1 = value["street1"]as? String,
            let city = value["city"]as? String,
            let state = value["state"]as? String,
            let zip = value["zip"]as? String
        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.startTime = startTime
        self.endTime = value["endTime"]as? Double
        self.street1 = street1
        self.street2 = value["street2"]as? String
        self.city = city
        self.state = state
        self.zip = zip
        self.description = value["description"]as? String
    }



    func toAnyObject() -> Any {
        return [
            "name":name,
            "startTime":startTime,
            "endTime":endTime,
            "street1":street1,
            "street2":street2,
            "city":city,
            "state":state,
            "zip":zip,
            "description":description 
        ]
    }
}

