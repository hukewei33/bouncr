//
//  InviteCard.swift
//  team10app
//
//  Created by GraceJoseph on 10/30/21.
//

import Foundation
import SwiftUI

struct InviteCard: View {
  
  var event: Event
  
  var body: some View {
    
    VStack(alignment: .leading) {
      
      // event name
      Text(event.name)
        .font(.system(size: 24))
        .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
      
      // address
      Text(event.street1)
        .font(.system(size: 16))
        .padding(.bottom)
      
      // description
      if (event.description != nil){
        
        Text((event.description)!)
          .font(.system(size: 12))
          .padding(.bottom)
        
      }
      
      
      // link to event
      NavigationLink(destination: EventDetailsView(event: event)){
        Text("See Event Details")
          .underline()
      }
      
      
      // QR CODE SHOULD GO HERE
      
      
      
      
      Spacer()
      
      
    }
    .padding()
    .accentColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
    .frame(minWidth: 280, minHeight: 400, alignment: .leading)
    .background(Color.white)
    .cornerRadius(16)
    .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0), lineWidth: 1)
              
    )
    
  }
  
}
