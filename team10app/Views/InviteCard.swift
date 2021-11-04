//
//  InviteCard.swift
//  team10app
//
//  Created by GraceJoseph on 10/30/21.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct InviteCard: View {
  
  // controller responsible for generating the qr code
  var qrViewController = QRViewController()
  
  // event associated with the invite
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
    
    VStack(alignment: .leading) {
      
      HStack(alignment: .top) {
        
        Text(dateStr)
          .font(.system(size: 14))
          .foregroundColor(.gray)
        
        Text("@host")
          .font(.system(size: 14))
          .foregroundColor(.gray)
        
      }.padding([.top, .bottom], 2.5)
      
      // event name
      Text(event.name)
        .font(.system(size: 24))
        .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
      
      // address
      Text(event.street1)
        .font(.system(size: 16))
        .padding(.bottom, 10)
      
      // description
      if (event.description != nil){
        
        Text((event.description)!)
          .font(.system(size: 12))
          .padding(.bottom, 10)
          .frame(height: 40)
          .truncationMode(.tail)
      }
      
      
      // link to event
      NavigationLink(destination: EventDetailsView(event: event)){
        Text("See Event Details")
          .underline()
      }
      
      // qr code (i assumed the user id to be 1)
      Image(uiImage: qrViewController.generateQRCode(from: "\(event.key)\n1"))
          .interpolation(.none)
          .resizable()
          .scaledToFit()
        .frame(width: 250, height: 250, alignment: .center)
      
      Spacer()
      
      
    }
    .padding()
    .accentColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
    .background(Color.white)
    .frame(height: 450, alignment: .leading)
    .cornerRadius(16)
    .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0), lineWidth: 1)
              

    )
    .clipped()
    .shadow(radius: 5)
    .padding()
    
  }
  
}
