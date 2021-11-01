//
//  Controller.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase

class Controller{
    
    
    
    
    let userInterface = UserInterface(userKey: "userKey")
    let eventInterface = EventInterface()
    let hostInterface = HostInterface(userKey: "userKey")
    let inviteInterface = InviteInterface()
    
    
    
    //creates an event and host relationship, returns key of host (intermediate table)
    func createEvent(name: String, startTime: Date, street1: String, street2: String?, city : String, zip: String , state:String, description : String?)->String?{
        if let newEventID = self.eventInterface.create(name: name, startTime: startTime,street1:  street1, street2: street2,city: city,zip:zip,state: state, description: description ),
           let userID = self.userInterface.CurrentUser?.key {
            return self.hostInterface.create(userKey: userID, eventKey: newEventID)
        }
        else{
            print("failed create new event hosting")
            return nil
        }
        
    }
    
    //index the events a user is hosting
    func indexHostEvents()-> [Event]{
        let eventIDs = self.hostInterface.Hosts.map {$0.eventKey}
        let myEvents = self.eventInterface.Events.filter {eventIDs.contains($0.key)}
        return myEvents
    }
    
    //get info about an event given key
    func viewEvent(key:String) -> Event?{
        let myEvents = self.eventInterface.Events.filter {$0.key == key}
        if myEvents.count == 1{
            return myEvents[0]
        }
        else{
            print("event not found")
            return nil
        }
    }
    
    //index events a user is invited to
    func indexGuestEvents()->[Event]{
        let eventIDs = self.inviteInterface.Invites.filter{$0.userKey == self.userInterface.CurrentUser?.key}.map {$0.eventKey}
        let myEvents = self.eventInterface.Events.filter {eventIDs.contains($0.key)}
        return myEvents
    }
    
    
    
    
    
    
    
}
