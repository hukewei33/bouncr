//
//  GuestList.swift
//  team10app
//
//  Created by Sara Song on 12/2/21.
//
import Foundation
import SwiftUI
import UIKit
import Combine

struct GuestList: View {
  
  @EnvironmentObject var viewModel: ViewModel
  var event: Event

  var body: some View {
    
    let checkedInInvites = self.viewModel.invites.filter {$0.eventKey == event.key && $0.checkinStatus && $0.inviteStatus}.map{$0.userKey}
    let checkedInGuests = self.viewModel.users.filter{checkedInInvites.contains($0.key)}
    let acceptedInvites = self.viewModel.invites.filter {$0.eventKey == event.key && !$0.checkinStatus && $0.inviteStatus}.map{$0.userKey}
    let acceptedGuests = self.viewModel.users.filter{acceptedInvites.contains($0.key)}
    let pendingInvites = self.viewModel.invites.filter {$0.eventKey == event.key && !$0.checkinStatus && !$0.inviteStatus}.map{$0.userKey}
    let pendingGuests = self.viewModel.users.filter{pendingInvites.contains($0.key)}
    
    NavigationView {
      
      List {
        
        Section(header: Text("Checked In Guests")) {
          
          // Checked in Guests
          ForEach(0..<checkedInGuests.count, id: \.self) { index in
            GuestListRow(guest: checkedInGuests[index])
          }
          
        }
        
        Section(header: Text("Accepted Guests")) {
          
          // Accepted Guests that haven't checked in
          ForEach(0..<acceptedGuests.count, id: \.self) { index in
            GuestListRow(guest: acceptedGuests[index])
          }
          
        }
        
        Section(header: Text("Pending Guests")) {
          
          // Pending Guests
          ForEach(0..<pendingGuests.count, id: \.self) { index in
            GuestListRow(guest: pendingGuests[index])
          }
          
        }
        
        
//        ForEach(0..<self.viewModel.indexEventGuests(eventKey: event.key).count, id: \.self) { index in
//          GuestListRow(guest: self.viewModel.indexEventGuests(eventKey: event.key)[index])
//        }
        
      }
//      .padding(.top, 20)
      
      .navigationTitle("Guest List")
    }
    
  }
}
