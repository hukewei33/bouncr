//
//  Event.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/3/22.
//

import Foundation


struct Event: Codable,JSONCreatable {
    
    let id: Int
    let name: String
    //start time of event in Date type casted as double
    let startTime: Date
    //end time of event in Date type casted as double
    let endTime: Date
    //Address info
    let street1: String
    let street2: String?
    let city: String
    let state: String
    let zip: Int
    let description: String?
    //setting options
    let attendenceVisible: Bool
    let friendsAttendingVisible: Bool
    let attendenceCap: Int
    let coverCharge: Double
    let isOpenInvite: Bool
    //location
    let venueLatitude: Double
    let venueLongitude: Double
    let organizations: [Organization]?
    
    
    func toDict() -> [String:String]? {
        var newEvent:[String:String] = [
                "name":name,
                "startTime":DateFormatter.iso8601Full.string(from:startTime),
                "endTime":DateFormatter.iso8601Full.string(from:endTime),
                "street1":street1,
                "street2":"",
                "city":city,
                "state":state,
                "zip":String(zip),
                "description":"",
                "attendenceVisible":String(attendenceVisible),
                "friendsAttendingVisible":String(friendsAttendingVisible),
                "isOpenInvite":String(isOpenInvite),
                "attendenceCap":String(attendenceCap),
                "coverCharge":String(coverCharge),
                "venueLatitude":String(venueLatitude),
                "venueLongitude":String(venueLongitude)
                ,
            ]
        if let s2 = street2{
            newEvent.updateValue(s2, forKey: "street2")
        }
        if let des = description{
            newEvent.updateValue(des, forKey: "description")
        }
        return newEvent
        }

}



