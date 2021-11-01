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
  //let hostInterface: HostInterface
  let inviteInterface: InviteInterface
  
  let hostsReference = Database.database().reference(withPath: "hosts")
  let eventsReference = Database.database().reference(withPath: "events")
//  let appDelegate: AppDelegate = AppDelegate()
  
  @Published var hosts: [Host] = [Host]()
  @Published var events: [Event] = [Event]()
  
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
    userInterface = UserInterface(userKey: "userKey")
    eventInterface = EventInterface()
    //hostInterface = HostInterface(userKey: "userKey")
    inviteInterface = InviteInterface()
    getHosts(userKey: "Tom")
    getEvents()
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
    func eventsForHosts() -> [Event] {
        let eventIDs: [String] = self.hosts.map {$0.eventKey}
        let myEvents = self.events.filter {eventIDs.contains($0.key)}
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

