//
//  HostUpcomingEventCard.swift
//  Bouncr
//
//  Created by Sara Song on 7/9/22.
//

import SwiftUI

struct HostUpcomingEventCard: View {
  
  @EnvironmentObject var mainController: MainController
  var event: Event
  let dateStr: String
  
  init(event: Event) {
    self.event = event
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, hh:mm a"
    dateStr = dateFormatter.string(from: event.startTime)
  }
  
  
  var body: some View {
    VStack {
      //Date & Time of upcoming event
      HStack {
        Text(dateStr)
          .bold()
          .font(.system(size: 12))
          .foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)))
        
        Spacer()
      }
      .padding([.top, .horizontal])
      
      //Event name, address, and num guests all in one row
      HStack {
        VStack(alignment: .leading) {
          Text(event.name)
            .font(.system(size: 22))
            .foregroundColor(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
            .padding(.bottom, 1)
            .lineLimit(1)
          
          Text(event.street1)
            .font(.system(size: 12))
            .foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)))
            .lineLimit(1)
        }
        
        Spacer()
    
        /*
        VStack {
          Text(String(self.viewModel.getEventAttendence(eventKey: event.key)[1]))
            .bold()
            .font(.system(size: 20))
          
          Text("guests invited")
            .font(.system(size: 12))
        }
         */
      }
      .padding(EdgeInsets(top: 2, leading: 15, bottom: 15, trailing: 15))
      
      //"More details" button
      MoreDetailsButton(event: event, ongoing: false)
      
    }
    .cornerRadius(10)
    .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)), lineWidth: 1)
    )
    .padding([.bottom, .horizontal])
  }
}
