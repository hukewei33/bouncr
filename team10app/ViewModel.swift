//
//  ViewModel.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit
import Firebase

class ViewModel: ObservableObject {
  
  var userInterface = UserInterface(userKey: "Dick")
  var eventInterface = EventInterface()
  var hostInterface = HostInterface(userKey: "Dick")
  var inviteInterface = InviteInterface()
  
  @Published var eventInvitations = [Event]()
  @Published var allEvents = [Event]()
  @Published var mainUser = User(firstName: "Dwight", lastName: "Schrute", email: "beets@gmail.com", username: "battlestarForever", profilePicURL: "")
  
  let appDelegate: AppDelegate = AppDelegate()
  
  let eventsReference = Database.database().reference(withPath: "events")

  func getEvents() {

    eventsReference.queryOrdered(byChild: "name").observe(.value, with: {
      snapshot in

      for child in snapshot.children {

        if let snapshot = child as? DataSnapshot,

           let event = Event(snapshot: snapshot) {

          self.allEvents.append(event)
          
        }

      }

    })

  }
  
  
  func indexGuestEvents() -> [Event]{
      let eventIDs = inviteInterface.Invites.filter{$0.userKey == userInterface.CurrentUser?.key}.map {$0.eventKey}
      let myEvents = eventInterface.Events.filter {eventIDs.contains($0.key)}
      print("eventIDS", eventIDs)
      eventInvitations = myEvents
      return myEvents
  }
  
  init() {
  
    getEvents()
    self.eventInterface.populate()
    print("pls workkkk", self.eventInterface.Events)
  print("helllllo")
//  print(indexGuestEvents())
 
    
  }
  
  
    
  
}


enum NavBarOptions {
  case myEvents
  case invitations
  case profile
}
