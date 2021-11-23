//
//  InviteGuestsModal.swift
//  team10app
//
//  Created by Sara Song on 11/4/21.
//

import SwiftUI

struct InviteGuestsModal: View {
  
  @Binding var show: Bool
  @ObservedObject var viewModel: ViewModel
  var event: Event
  @State private var search: String = ""


  var body: some View {
    ZStack {
      if show {
        // Background color
        Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
        // PopUp Window
        VStack(alignment: .leading) {
          HStack {
            //Close popup button
            Button(action: {
               self.viewModel.clearToBeInvited()
               // Dismiss the PopUp
               withAnimation(.linear(duration: 0.3)) {
                   show = false
               }
            }, label: {
               Image(systemName: "x.circle")
                .font(.title2)
                .foregroundColor(Color.black)
            })
            
            Spacer()
            
            Text("Invite Guests")
              .font(.system(size: 20))
            
            Spacer()
          }
          .padding(.bottom)
          
          
          HStack {
            Spacer()
            
            VStack {
              
              //Search bar
              TextField(
                "Search for users",
                text: $search
              )
              .padding(.bottom, 30)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              
              //List of users
              ScrollView {
                  VStack(alignment: .leading) {
                    ForEach(0..<self.viewModel.getNotInvitedUsers(eventKey: event.key).count, id: \.self) { index in
                      InviteGuestsModalRow(viewModel: self.viewModel, user: self.viewModel.getNotInvitedUsers(eventKey: event.key)[index])
                        .padding(10)
                    }
                  }
                  .padding()
              }
              .cornerRadius(10)
              .frame(width: 250, height: 375)
              .border(Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)))
              
            }
            
//            ScrollView {
//                VStack(alignment: .leading) {
//                  ForEach(0..<self.viewModel.getNotInvitedUsers(eventKey: event.key).count, id: \.self) { index in
//                    InviteGuestsModalRow(viewModel: self.viewModel, user: self.viewModel.getNotInvitedUsers(eventKey: event.key)[index])
//                      .padding(10)
//                  }
//                }
//                .padding()
//            }
//            .cornerRadius(10)
//            .frame(width: 250, height: 400)
//            .border(Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)))
            
            Spacer()
          }
          
          
          //Button to send invites
          HStack {
            Spacer()
            Button(action: {
              self.viewModel.sendInvites(event: self.event)
              withAnimation(.linear(duration: 0.3)) {
                  show = false
              }
            }, label: {
               Text("Send Invites")
                .bold()
                .frame(width: 128, height:41)
                .foregroundColor(Color.white)
                .font(Font.system(size: 17))
            })
            .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
            .cornerRadius(10)
          }
          
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.white)
        .cornerRadius(10)

      }
    }
  }
}
