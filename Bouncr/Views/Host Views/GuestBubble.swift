//
//  GuestBubble.swift
//  Bouncr
//
//  Created by Sara Song on 7/19/22.
//

import SwiftUI

struct GuestBubble: View {
  
  var user: OtherUser
  
  var body: some View {
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
      
      Text(user.firstName)
        .font(.system(size: 10))
    } //End VStack
    .frame(width: 50)
  } //End var body: some View
}
