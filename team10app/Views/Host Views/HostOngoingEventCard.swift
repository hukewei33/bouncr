//
//  HostOngoingEventCard.swift
//  team10app
//
//  Created by Sara Song on 10/31/21.
//

import SwiftUI

struct HostOngoingEventCard: View {
  
  var event: Event
  let date: Date
  let dateStr: String
  
  init(event: Event) {
    self.event = event
    let timeInterval = TimeInterval(event.startTime)
    date = Date(timeIntervalSince1970: timeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, hh:mm a"
    dateStr = dateFormatter.string(from: date)
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
        
        //Event name, address, and scan QR button all in one row
        HStack {
          VStack(alignment: .leading) {
            HStack {
              Text("EventName")
                .font(.system(size: 28))
                .foregroundColor(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
                .padding(.bottom, 1)
                .lineLimit(1)
              Circle()
                .fill(Color(#colorLiteral(red: 0.262745098, green: 0.8784313725, blue: 0, alpha: 1)))
                .frame(width: 12, height: 12)
            }
            
            Text("Address")
              .font(.system(size: 17))
              .foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)))
              .lineLimit(1)
          }
          
          Spacer()
      
          //Button to scan QR Codes
          //CHANGE TO NAVIGATE TO QR CAMERA SCANNER VIEW!!
          NavigationLink(destination: InvitationsView()) {
            SquareScanQR()
          }
          
        }
        .padding(EdgeInsets(top: 2, leading: 15, bottom: 15, trailing: 15))
        
        Text("#/## guests checked in")
          .font(.system(size: 17))
          .padding(EdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 15))
        
        //"More details" button
        MoreDetailsButton(event: event, ongoing: true)
        
      }
      .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 0.05)))
      .cornerRadius(10)
      .overlay(
          RoundedRectangle(cornerRadius: 10)
              .stroke(Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)), lineWidth: 1)
      )
      .padding(.horizontal)
    }
}
