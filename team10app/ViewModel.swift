//
//  ViewModel.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import Foundation
import Combine
import Firebase

class ViewModel: ObservableObject {
    
    let userInterface: UserInterface
    let eventInterface: EventInterface
    let hostInterface: HostInterface
    let inviteInterface: InviteInterface
    
    let hostsReference = Database.database().reference(withPath: "hosts")
    let eventsReference = Database.database().reference(withPath: "events")
    let usersReference = Database.database().reference(withPath: "users")
    let invitesReference = Database.database().reference(withPath: "invites")
    
    //  let appDelegate: AppDelegate = AppDelegate()
    
    @Published var hosts: [Host] = [Host]()
    @Published var events: [Event] = [Event]()
    @Published var users: [User] = [User]()
    @Published var invites: [Invite] = [Invite]()
    //@Published var thisUser: User = nil
    
    //  func createEvent(name: String, startTime: Date, street1: String, street2: String?, city : String, zip: String , state:String, description : String?)->String?{
    //      if let newEventID = self.eventInterface.create(name: name, startTime: startTime,street1:  street1, street2: street2,city: city,zip:zip,state: state, description: description ),
    //         let userID = self.userInterface.CurrentUser?.key {
    //          return self.hostInterface.create(userKey: userID, eventKey: newEventID)
    //      }
    //      else{
    //          print("failed create new event hosting")
    //          return nil
    //      }
    //  }
    
    init() {
        //lets keep the interfaces for CUD so we dont blow up this file :)
        
        //we also need to think about a login process for v2
        
        userInterface = UserInterface(userKey: "Tom")
        eventInterface = EventInterface()
        hostInterface = HostInterface(userKey: "Tom")
        inviteInterface = InviteInterface()
        getHosts(userKey: "Tom")
        getEvents()
        getUsers(userKey:"Tom")
        getInvites()
    }
    
    func indexHostEvents() -> [Event] {
        print("indexHostEvents!!!")
        //getHosts(userKey: "Tom")
        let eventIDs: [String] = self.hosts.map {$0.eventKey}
        let myEvents = self.events.filter {eventIDs.contains($0.key)}
        //    self.events = myEvents
        return myEvents
    }
    
    //For some reason, this is only called after everything else
    func getHosts(userKey: String) {
        hostsReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let host = Host(snapshot: snapshot) {
                    if host.userKey == userKey{
                        self.hosts.append(host)
                        print(host.userKey)
                    }
                }
            }
            print("newHosts ", self.hosts)
            print("COUNT", self.hosts.count)
        })
        
    }
    
    func getEvents() {
        self.eventsReference.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let event = Event(snapshot: snapshot) {
                    //print(event.name)
                    self.events.append(event)
                }
            }
        })
    }
    
    func getUsers(userKey: String){
        self.usersReference.queryOrdered(byChild: "firstName").observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let user = User(snapshot: snapshot) {
                    self.users.append(user)
//                    if user.key == userKey{
//                        self.thisUser = user
//                    }
                }
            }
        })
    }
    
    func getInvites(){
        self.invitesReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let invite = Invite(snapshot: snapshot) {
                    self.invites.append(invite)
                    //print(invite.userKey)
                }
            }
        })
    }
    
    func eventsForHosts() -> [Event] {
        let eventIDs: [String] = self.hosts.map {$0.eventKey}
        let myEvents = self.events.filter {eventIDs.contains($0.key)}
        return myEvents
    }
    
    func viewEvent(key:String) -> Event?{
        let myEvents = self.events.filter {$0.key == key}
        if myEvents.count == 1{
            return myEvents[0]
        }
        else{
            print("event not found")
            return nil
        }
    }
    
    func indexGuestEvents()->[Event]{
        let eventIDs = self.invites.filter{$0.userKey == self.userInterface.CurrentUser?.key}.map {$0.eventKey}
        let myEvents = self.events.filter {eventIDs.contains($0.key)}
        return myEvents
    }
    
    //creates an event and host relationship, returns key of host (intermediate table)
    func createEvent(name: String, startTime: Date, endTime: Date, street1: String, street2: String?, city : String, zip: String , state:String, description : String?)->String?{
        if let newEventID = self.eventInterface.create(name: name, startTime: startTime,endTime:endTime,street1:  street1, street2: street2,city: city,zip:zip,state: state, description: description ),
           //we need a way to get login and store the user info of this user
           let userID = self.userInterface.CurrentUser?.key {
            return self.hostInterface.create(userKey: userID, eventKey: newEventID)
        }
        else{
            print("failed create new event hosting")
            return nil
        }
    }
    
    func checkin(inviteKey:String)->Bool{
        //use invitekey to get invite
        let thisInvite = self.invites.filter{$0.key == inviteKey}.map{$0.eventKey}
        //use eventid of invite to get hosts
        let hostIDs = self.hosts.filter{thisInvite.contains($0.eventKey)}.map{$0.key}
        //check myid is one of the hosts
        if hostIDs.contains("hostID"){
            //update
            self.inviteInterface.update(key: inviteKey, updateVals: ["checkinStatus" : true,"checkinTime":Date().timeIntervalSinceReferenceDate])
            return true
        }
        else{
            return false
        }
        
        
    }
    

    
}

