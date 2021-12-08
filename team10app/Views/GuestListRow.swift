//
//  GuestListRow.swift
//  team10app
//
//  Created by Sara Song on 12/2/21.
//
import SwiftUI

struct GuestListRow: View {
  
  var guest: User
  
  var body: some View {
    
    HStack(alignment: .center) {
      
      // use a default if null
      if (guest.profilePicURL == nil || guest.profilePicURL == ""){

        Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
          .resizable()
          .frame(width: 30, height: 30)
          .aspectRatio(contentMode: .fit)
          .cornerRadius(15)
          .padding(.trailing, 10)

      }
      // display the non-nil profile pic
      else {
        
        Image(uiImage: guest.profilePicURL!.load())
          .resizable()
          .frame(width: 30, height: 30)
          .aspectRatio(contentMode: .fit)
          .cornerRadius(15)
          .padding(.trailing, 10)
        
      }
      
      
      VStack (alignment: .leading) {
        
        Group {
          
          
          Text("\(guest.firstName) \(guest.lastName)")
          Text("@" + guest.username)
            .foregroundColor(Color("Gray - 400"))
            .font(.system(size: 14))
          
        }
        
//        .padding(.vertical, 5)
      }
      
    }
    
    
  }
}
