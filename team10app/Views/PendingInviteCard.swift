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
  
  
  init(viewModel: ViewModel, invite: Invite){
    self.viewModel = viewModel
    self.invite = invite
  }
  
  func initView() {
    let allEvents = self.viewModel.currentEvents + self.viewModel.events
    print("i hate everything")
    print(allEvents)
    print(self.viewModel.currentEvents)
    print(self.viewModel.events)
    print(allEvents.filter{$0.key == invite.eventKey})
    let startTimeInterval = TimeInterval(allEvents.filter{$0.key == invite.eventKey}[0].startTime)
    startTime = Date(timeIntervalSince1970: startTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, h:mm a"
    dateStr = dateFormatter.string(from: startTime)
  }

  
  
  var body: some View {
    
    let allEvents = self.viewModel.currentEvents + self.viewModel.events
    
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
        
      if (self.viewModel.indexEventHosts(eventKey: invite.eventKey).count > 0) {

            Text("@" + self.viewModel.indexEventHosts(eventKey: invite.eventKey)[0].username + " ")
              .bold()
            + Text("has invited you to ")
          + Text(allEvents.filter{$0.key == invite.eventKey}[0].name)
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
