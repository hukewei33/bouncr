//
//  PendingGuestsBubbles.swift
//  Bouncr
//
//  Created by Sara Song on 7/19/22.
//

import SwiftUI

struct PendingGuestsBubbles: View {
  @EnvironmentObject var mainController: MainController
  @ObservedObject var otherUserController: OtherUserController
  var event: Event
  @Binding var showInviteModal: Bool
  
  //Constants
  let rows = [GridItem(.fixed(30))]

  var body: some View {
    
    //Header on left:
    Text("Pending Guests: ")
      .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
    
    LazyHGrid(rows: rows, alignment: .lastTextBaseline) {
      // Button to invite guests
      VStack {
         Button(action: {
           withAnimation(.linear(duration: 0.3)) {showInviteModal.toggle()}
         }, label: {
           Image(systemName: "plus")
             .foregroundColor(Color.white)
             .frame(width: 30, height: 30)
         })
         .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
         .cornerRadius(38.5)
         .shadow(color: Color.black.opacity(0.3),
                 radius: 3,
                 x: 3,
                 y: 3)

         Text("Add Guests")
           .multilineTextAlignment(.center)
           .font(.system(size: 10))
           .frame(height: 25)
           
      } //End button's VStack
       .padding(.top, 20)
       .frame(width: 50, height: 55, alignment: .center)
      
      if otherUserController.pendingInvitesOtherUserArray.count > 3 {
        ForEach(0..<2){ index in
          GuestBubble(user: otherUserController.pendingInvitesOtherUserArray[index])
        }//End ForEach
        
        SeeMoreButton(event: event)
      }//End if
      else {
        ForEach(0..<otherUserController.pendingInvitesOtherUserArray.count, id: \.self){ index in
          GuestBubble(user: otherUserController.pendingInvitesOtherUserArray[index])
        }//End ForEach
      }//End else
      
    } //End LazyHGrid
    .onAppear() {
      mainController.otherUserController.getPendingInviteGuests(eventID: event.id)
    }

  } //End var body: some View
}


