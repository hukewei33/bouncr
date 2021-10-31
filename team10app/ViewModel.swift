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
  
  let userInterface = UserInterface(userKey: "Dick")
  let eventInterface = EventInterface()
  let hostInterface = HostInterface(userKey: "Dick")
  let inviteInterface = InviteInterface()
  
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
      let eventIDs = self.inviteInterface.Invites.filter{$0.userKey == self.userInterface.CurrentUser?.key}.map {$0.eventKey}
      let myEvents = self.eventInterface.Events.filter {eventIDs.contains($0.key)}
      print("eventIDS", eventIDs)
      self.eventInvitations = myEvents
      return myEvents
  }
  
  init() {
    
  indexGuestEvents()
  getEvents()
  eventInterface.populate()
    print("helllllo")
    print(self.allEvents)
    
  }
  
  
    
  
}


enum NavBarOptions {
  case myEvents
  case invitations
  case profile
}
