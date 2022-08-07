//
//  InviteGuestsModal.swift
//  Bouncr
//
//  Created by Sara Song on 7/23/22.
//

import SwiftUI

struct InviteGuestsModal: View {
  
  @Binding var show: Bool
  @EnvironmentObject var mainController: MainController
  @ObservedObject var otherUserController: OtherUserController
  var event: Event
  
  @State private var searchText: String = ""
  @State private var searchResults: [OtherUser] = []
  @State private var checkedUsers: [OtherUser] = []
  
  init(show: Binding<Bool>, event: Event, otherUserController: OtherUserController){
    self._show = show
    self.event = event
    self.otherUserController = otherUserController
  }
  
  //Copied & edited from SwiftRepos lab, for search functionality
  func displayResults() {
    if searchText == "" {
      searchResults = []
    } else {
      mainController.otherUserController.getSearch(term: searchText)
      searchResults = otherUserController.otherUserArray
    }
  }

  

  var body: some View {
    
    //Copied & edited from SwiftRepos lab, for searh functionality
    let binding = Binding<String>(get: {
      self.searchText
    }, set: {
      self.searchText = $0
      self.displayResults()
    })
    
    ZStack {
      if show {
        // Background color
        Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
        // PopUp Window
        VStack(alignment: .leading) {
          HStack {
            //Close popup button
            Button(action: {
              self.checkedUsers = []
              
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
                text: binding
              )
              .padding(.bottom, 30)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              
              
              //List of users
              ScrollView {
                  VStack(alignment: .leading) {
                    //Can only show users if they exist in search results
                    if (searchResults.count>0) {
                      ForEach(0..<self.searchResults.count, id: \.self) { index in
                        InviteGuestsModalRow(user: self.searchResults[index], checkedUsers: $checkedUsers)
                          .padding(10)
                      }
                    }
                    //Display appropriate message if there are no relevant search results
                    else {
                      Text("No search results")
                        .foregroundColor(Color("Gray - 400"))
                    }
                  }
                  .padding()
              }
              .cornerRadius(10)
              .frame(width: 250, height: 375)
              .border(Color("Gray - 100"))
              
            }
            
            Spacer()
          }
          
          
          //Button to send invites
          HStack {
            Spacer()
            Button(action: {
              for user in self.checkedUsers {
                let newInvite = Invite(id: 42, user_id: user.id, event_id: event.id, checkinTime: nil, inviteStatus: false, coverChargePaid: 0, event: nil, user: nil)
                mainController.inviteController.createInvite(newInvite: newInvite){mainController.otherUserController.getPendingInviteGuests(eventID: event.id)}
              }
              mainController.otherUserController.getAllGuests(eventID: event.id)
              
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
