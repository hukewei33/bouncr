//
//  GuestList.swift
//  Bouncr
//
//  Created by Sara Song on 7/19/22.
//

import Foundation
import SwiftUI
import UIKit
import Combine

struct GuestList: View {
  
  @EnvironmentObject var mainController: MainController
  @ObservedObject var otherUserController: OtherUserController
  var event: Event
  var guestHost: String

  var body: some View {
    
    List {
      
      if (guestHost=="host") {
        
        // Checked in Guests
        Section(header: Text("Checked In Guests")) {
          if (otherUserController.otherUserArray.count>0) {
            ForEach(otherUserController.otherUserArray) { user in
              GuestListRow(guest: user)
            }
          }
          else {
            Text("No guests are currently checked-in")
          }
        }//end Section
        .onAppear() {
          //Populate otherUserArray w/ ppl who checked in
          otherUserController.getGuests(eventID: event.id, checkedin: true, inviteStatus: true, isFriend: nil)
        }
        
        
        // Guests who've accepted their invites but haven't checked in
        Section(header: Text("Accepted Guests")) {
          if (otherUserController.acceptedInvitesOtherUserArray.count>0) {
            ForEach(otherUserController.acceptedInvitesOtherUserArray) { user in
              GuestListRow(guest: user)
            }
          }
          else {
            Text("No guests have accepted their invites yet")
          }
        }//end Section
        
        
        // Guests who haven't accepted their invites
        Section(header: Text("Pending Guests")) {
          if (otherUserController.pendingInvitesOtherUserArray.count>0) {
            ForEach(otherUserController.pendingInvitesOtherUserArray) { user in
              GuestListRow(guest: user)
            }
          }
          else {
            Text("No invites are currently pending")
          }
        }//end Section
      }// end if
      
      //If you're a guest viewing the guestlist, just view all the guests in a single section
      else {
        Section(header: Text("All Guests")) {
          if (otherUserController.allGuestsOtherUserArray.count>0) {
            ForEach(otherUserController.allGuestsOtherUserArray) { user in
              GuestListRow(guest: user)
            }
          }
          else {
            Text("No guests are invited yet")
          }
        }
      }//end else
      
    } //end List
    .navigationTitle("Guest List")
//    .navigationViewStyle(StackNavigationViewStyle())
    
  }
}
