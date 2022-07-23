//
//  SeeMoreButton.swift
//  Bouncr
//
//  Created by Sara Song on 7/19/22.
//

import SwiftUI

struct SeeMoreButton: View {
  
  var event: Event
  
  var body: some View {
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
  }
}
