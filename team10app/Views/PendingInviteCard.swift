//
//  PendingInviteCard.swift
//  team10app
//
//  Created by GraceJoseph on 11/28/21.
//

import Foundation
import SwiftUI

struct PendingInviteCard: View {
  
  @ObservedObject var viewModel: ViewModel
  
  var invite: Invite
  @State var startTime = Date()
  @State var date = Date()
  @State var dateStr : String = ""
  
  func initView() {
    let startTimeInterval = TimeInterval(viewModel.events.filter{$0.key == invite.eventKey}[0].startTime)
//    startTime = Date(timeIntervalSinceReferenceDate: startTimeInterval)
    startTime = Date(timeIntervalSince1970: startTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, hh:mm a"
    dateStr = dateFormatter.string(from: startTime)
  }

  
  
  var body: some View {
    
    VStack(alignment: .leading) {
      
//      if (self.viewModel.viewEvent(key: invite.eventKey) != nil){
//
//        Text(self.viewModel.viewEvent(key: invite.eventKey)!.name)
//          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
//
//      }
      
//      Text(String(viewModel.hosts.count))
//      Text(invite.eventKey)
//      Text(String(viewModel.indexEventHosts(eventKey: invite.eventKey).count))
//      Text(String(self.viewModel.events.count))
        
        if (viewModel.indexEventHosts(eventKey: invite.eventKey).count > 0) {

            Text("@" + self.viewModel.indexEventHosts(eventKey: invite.eventKey)[0].username + " ")
              .bold()
            + Text("has invited you to ")
          + Text(self.viewModel.events.filter{$0.key == invite.eventKey}[0].name)
              .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          + Text(" on ")
          + Text(dateStr)
          
        }
      
    }
      .onAppear{ initView() }
      .padding([.leading, .trailing], 10)
      .padding([.top, .bottom], 5)
      .frame(height: 60)
    
    
    
    
  }
  
}
