//
//  InviteGuestsModal.swift
//  team10app
//
//  Created by Sara Song on 11/4/21.
//

import SwiftUI

struct InviteGuestsModal: View {
  
  //Fields to pass into Modal:
  //  - Event (to create invites from)
  //  - List of all Users
  
  @Binding var show: Bool
  
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
          
          //Search bar
          
          
          //List of users
          ScrollView {
            VStack(alignment: .leading) {
              
            }
            .padding()
            .frame(width: 250)
          }
          .cornerRadius(10)
          .border(Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)))
          
          
          
          HStack {
            Spacer()
            Button(action: {
               // Dismiss the PopUp
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
