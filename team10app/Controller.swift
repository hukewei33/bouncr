//
//  Controller.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase

class Controller {
    let userInterface = UserInterface(userKey: "userKey")
    let eventInterface = EventInterface()
    let hostInterface = HostInterface(userKey: "userKey")
    let inviteInterface = InviteInterface()
    
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
    
    func indexHostEvents()-> [Event]{
        let eventIDs = self.hostInterface.Hosts.map {$0.eventKey}
        let myEvents = self.eventInterface.Events.filter {eventIDs.contains($0.key)}
        return myEvents
    }
    
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
    
    func indexGuestEvents()->[Event]{
        let eventIDs = self.inviteInterface.Invites.filter{$0.userKey == self.userInterface.CurrentUser?.key}.map {$0.eventKey}
        let myEvents = self.eventInterface.Events.filter {eventIDs.contains($0.key)}
        return myEvents
    }
    
    
    
    
    
    
    
}
