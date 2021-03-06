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
  
  @EnvironmentObject var viewModel: ViewModel
  
  // controller responsible for generating the qr code
  var qrViewController = QRViewController()
  
  // event associated with the invite
  var event: Event
//  var cardIndex: Int
  
//  var hosts = viewModel.indexEventHosts(eventKey: event.key)

  let date: Date
  let dateStr: String
  
  init(event: Event) {
//    self.cardIndex = cardIndex
    self.event = event
    let timeInterval = TimeInterval(event.startTime)
    date = Date(timeIntervalSince1970: timeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, hh:mm a"
    dateStr = dateFormatter.string(from: date)
  }
  
  var body: some View {
    
    let currentInvite = self.viewModel.invites.filter{$0.eventKey == event.key && $0.userKey == self.viewModel.thisUser!.key}[0]
    let checkedIn = currentInvite.checkinStatus
    
    VStack(alignment: .leading) {
      
//      NavigationLink(destination: InvitationsHorizontalView(cardIndex: cardIndex)){
        
        VStack(alignment: .leading){
          
          HStack(alignment: .top) {
            
            Text(dateStr)
              .font(.system(size: 16))
              .foregroundColor(.gray)
            
              //Text("@host")
                
    //        Text("@" + viewModel.indexEventHosts(eventKey: event.key)[0].username)
    //          .font(.system(size: 14))
    //          .foregroundColor(.gray)
            
          }
          .padding(.top, 5)
        
          // event name
          Text(event.name)
            .font(.system(size: 28))
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            .lineLimit(1)
          
          // address
          Text(event.street1)
            .font(.system(size: 18))
            .padding(.bottom, 10)
            .foregroundColor(.black)
          
        }
        
//      }
        
        
        // description
        if (event.description != nil){
          
          Text((event.description)!)
            .lineLimit(2)
            .font(.system(size: 14))
            .padding(.bottom, 10)
            .frame(width: 200, height: 40, alignment: .leading)
            
        }
      
        Spacer()
      
        
      
      // link to event
      NavigationLink(destination: EventDetailsView(event: event)){
        Text("See Event Details")
          .underline()
      }
      
      // qr code
      Image(uiImage: qrViewController.generateQRCode(from: "\(event.key)\n\(self.viewModel.thisUser!.key)"))
          .interpolation(.none)
          .resizable()
          .scaledToFit()
        .frame(width: 250, height: 250, alignment: .center)
      
      
    }
    .padding()
    .accentColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
    .background(checkedIn ? (LinearGradient(gradient: Gradient(colors: [Color(red: 230/255, green: 239/255, blue: 1.0, opacity: 1), Color(red: 236/255, green: 233/255, blue: 1.0, opacity: 1)]), startPoint: .leading, endPoint: .trailing)) : (LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .leading, endPoint: .trailing)))
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
