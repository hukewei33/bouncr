//
//  AttendingGuestsBubbles.swift
//  Bouncr
//
//  Created by Sara Song on 7/19/22.
//

import SwiftUI

struct AttendingGuestsBubbles: View {
  @EnvironmentObject var mainController: MainController
  @ObservedObject var otherUserController: OtherUserController
  var event: Event
  
  //Constants
  let rows = [GridItem(.fixed(30))]

  var body: some View {
    
    //Header on left:
    Text("Accepted Guests: ")
      .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
    
    LazyHGrid(rows: rows, alignment: .lastTextBaseline) {
      
      if otherUserController.acceptedInvitesOtherUserArray.count > 4 {
        ForEach(0..<3){ index in
          GuestBubble(user: otherUserController.acceptedInvitesOtherUserArray[index])
        }//End ForEach
        
        SeeMoreButton(event: event)
      }//End if
      else {
        ForEach(otherUserController.acceptedInvitesOtherUserArray) { user in
          GuestBubble(user: user)
        }//End ForEach
      }//End else
      
    } //End LazyHGrid
    .onAppear() {
      mainController.otherUserController.getAcceptedInvitesGuests(eventID: event.id)
    }

  } //End var body: some View
}
