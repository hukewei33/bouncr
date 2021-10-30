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
  
  @Published var eventInvitations = [Event]()
  @Published var mainUser = User(firstName: "Dwight", lastName: "Schrute", email: "beets@gmail.com", username: "battlestarForever", profilePicURL: "")
  
  let appDelegate: AppDelegate = AppDelegate()
  
  let eventsReference = Database.database().reference(withPath: "events")

  func getEvents() {
    
    eventsReference.queryOrdered(byChild: "name").observe(.value, with: {
      snapshot in
      
      var newEventInvitations: [Event] = []
      for child in snapshot.children {
        
        if let snapshot = child as? DataSnapshot,
           
           let event = Event(snapshot: snapshot) {
          
          newEventInvitations.append(event)
          print(event)
          print(snapshot)
        }
        
      }
      
      self.eventInvitations = newEventInvitations
      
    })

  }
    
  
//  func goBack() {
//    webViewOptionsPublisher.send(.back)
//  }
//
//  func goForward() {
//    webViewOptionsPublisher.send(.forward)
//  }
//
//  func share() {
//    webViewOptionsPublisher.send(.share)
//  }

  
}


enum NavBarOptions {
  case myEvents
  case invitations
  case profile
}
