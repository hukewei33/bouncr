//
//  EventDetailsGuestBubbles.swift
//  Bouncr
//
//  Created by Sara Song on 7/18/22.
//

import SwiftUI

struct EventDetailsGuestBubbles: View {
  
  @EnvironmentObject var mainController: MainController
  @ObservedObject var otherUserController: OtherUserController
  var event: Event
  //If this row shows pending guests, rowCount=3
  //If it shows accepted guests instead, rowCount=4
  var rowCount: Int
  @Binding var showInviteModal: Bool
  @State private var guestArray: [OtherUser] = []
  
  //Constants
  let rows = [GridItem(.fixed(30))]
  let pendingCount = 3
  let acceptedCount = 4

  var body: some View {
    
    //Header on left:
    if rowCount==pendingCount {
      Text("Pending Guests: ")
        .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
    } else if rowCount==acceptedCount {
      Text("Accepted Guests: ")
        .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
    }
    
    LazyHGrid(rows: rows, alignment: .lastTextBaseline) {
      if rowCount==pendingCount {
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
      } //End if rowCount==pendingCount
      
      if guestArray.count > rowCount {
        ForEach(0..<(rowCount-1), id: \.self){ index in
          VStack {
            //UNCOMMENT WHEN OTHERUSER MODEL HAS PROFILEPICURL
//            if (guestArray[index].profilePicURL == nil || guestArray[index].profilePicURL == ""){
//
//              Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
//                .resizable()
//                .frame(width: 30, height: 30)
//                .aspectRatio(contentMode: .fit)
//                .cornerRadius(15)
//
//            }
//            // display the non-nil profile pic
//            else {
//
//              Image(uiImage: guestArray[index].profilePicURL!.load())
//                .resizable()
//                .frame(width: 30, height: 30)
//                .aspectRatio(contentMode: .fit)
//                .cornerRadius(15)
//            }
            
            Image(systemName: "person.circle")
              .resizable()
              .frame(width: 30, height: 30)
              .aspectRatio(contentMode: .fit)
            
            Text(guestArray[index].firstName)
              .font(.system(size: 10))
            
          }// End VStack
          .frame(width: 50)
          
        }//End ForEach
        
        //See More button
        VStack {
          NavigationLink(destination: GuestList(event: event, guestHost: "host")){
            Image(systemName: "ellipsis")
               .foregroundColor(Color.white)
               .frame(width: 30, height: 30)
          } //End NavigationLink
           .background(Color(.gray))
           .cornerRadius(38.5)
           .shadow(color: Color.black.opacity(0.3),
                   radius: 3,
                   x: 3,
                   y: 3)

           Text("See More")
             .multilineTextAlignment(.center)
             .font(.system(size: 10))
        }//End VStack
       .frame(width: 50, height: 50, alignment: .center)
      }//End if guestArray.count>rowCount
      
    } //End LazyHGrid
    .onAppear() {
      if rowCount==pendingCount {
        otherUserController.getPendingInviteGuests(eventID: event.id)
        guestArray = otherUserController.pendingInvitesOtherUserArray
      }
      else if rowCount==acceptedCount {
        otherUserController.getAcceptedInvitesGuests(eventID: event.id)
        guestArray = otherUserController.acceptedInvitesOtherUserArray
      }
    }

  } //End var body: some View
}
