//
//  GuestListRow.swift
//  Bouncr
//
//  Created by Sara Song on 8/27/22.
//

import SwiftUI

struct GuestListRow: View {
  
  var guest: OtherUser
  
  var body: some View {
    
    HStack(alignment: .center) {
      
      Image(systemName: "person.circle")
        .resizable()
        .frame(width: 30, height: 30)
        .aspectRatio(contentMode: .fit)
        .cornerRadius(15)
        .padding(.trailing, 10)
      
      VStack (alignment: .leading) {
        
        Group {
          
          Text("\(guest.firstName) \(guest.lastName)")
          Text("@" + guest.username)
            .foregroundColor(Color("Gray - 400"))
            .font(.system(size: 14))
          
        }
      }
    }
  }
}
