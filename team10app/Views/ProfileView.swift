//
//  ProfileView.swift
//  team10app
//
//  Created by GraceJoseph on 10/29/21.
//

import Foundation
import SwiftUI
import UIKit
import Combine


struct ProfileView: View {
  
  var user: User
  @EnvironmentObject var viewModel: ViewModel
//  @State private var viewFriendRequests = true
  
  init(user: User){
    self.user = user
  }
  
    var body: some View {
      
      NavigationView {
        
        let friendRequests = self.viewModel.pendingFriends.filter{$0.userKey1 == self.viewModel.thisUser!.key}
        let friends = self.viewModel.friends.filter{$0.userKey1 == self.viewModel.thisUser!.key}
          
        
        VStack {

          // TOPBAR

          HStack {

            // need to still write code for profile pic here
            
            
            // use a default if null
            if (viewModel.thisUser!.profilePicURL == nil || viewModel.thisUser!.profilePicURL == ""){

              Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(50)

            }
            // display the non-nil profile pic
            else {
              
              Image(uiImage: viewModel.thisUser!.profilePicURL!.load())
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(50)
                .padding([.leading, .trailing], 5)
              
            }
            
           

            VStack(alignment: .leading) {

              // display username
              Text("@" + viewModel.thisUser!.username)
                .foregroundColor(.white)
                .font(.subheadline)


              // display name
              Text(viewModel.thisUser!.firstName + " " + viewModel.thisUser!.lastName)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 24))

            }
            
            .padding([.leading, .trailing], 5)
            Spacer()
            
            NavigationLink(destination: EditProfile()){
              
              ZStack {
                Image(systemName: "square.and.pencil")
                  .font(.system(.title))
                  .frame(width: 20, height: 20)
                  .foregroundColor(.white)
                  
              }
              .padding([.leading, .trailing], 5)
                
            }
            

          }
          .frame(maxWidth: .infinity, minHeight: 180)
          .padding(.top, 50)
          .padding(.bottom, 0)
          .padding([.horizontal], 30)
          .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          .edgesIgnoringSafeArea(.top)
          
          if (self.viewModel.thisUser != nil){
            
            List {
              
              NavigationLink(destination: AddFriends()) {
                Text("Make Friend Request")
                  .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
              }
              .navigationBarTitleDisplayMode(.inline)
              .navigationBarHidden(true)
              
              
              if (friendRequests.count > 0){
                
                Section(header: Text("Friend Requests")){
                  
                  
                  ForEach(0..<friendRequests.count, id: \.self) { index in
                    
                    Group {
                      Text(self.viewModel.users.filter{$0.key == self.viewModel.pendingFriends[index].userKey2}[0].firstName) +
                      Text(" ") +
                      Text(self.viewModel.users.filter{$0.key == self.viewModel.pendingFriends[index].userKey2}[0].lastName)
                    }
                        .swipeActions(edge: .trailing) {
                          Button(action: {
//                            print("friend req accepted")
                            self.viewModel.acceptFriendInvite(acceptedInvite: self.viewModel.pendingFriends[index])
//                            print(self.viewModel.pendingFriends)
                          }){
                            HStack{
                              Text("Accept")
                              Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            }
                          }
                          .tint(.green)
                        }
                        .swipeActions(edge: .leading) {
                          Button(action: {
//                            print("friend req declined")
                            self.viewModel.rejectFriend(rejectedInvite: self.viewModel.pendingFriends[index])
                          }){
                            HStack{
                              Text("Decline")
                              Image(systemName: "x.circle")
                                .foregroundColor(.white)
                            }
                          }
                          .tint(.red)
                        }
                    
                  
                  }
                   
                  
                }
                
              }
              
              if (friends.count > 0){
                
                  
                  // list of current friends the user has
                  Section(header: Text("Friends")){
                    
                    
                    ForEach(0..<friends.count, id: \.self) { index in
                      
                    
                        
                        Group {
                          Text(self.viewModel.users.filter{$0.key == self.viewModel.friends[index].userKey2}[0].firstName) +
                          Text(" ") +
                          Text(self.viewModel.users.filter{$0.key == self.viewModel.friends[index].userKey2}[0].lastName)
                      
                        }
                    
                    
                    }
                  }
              }
              
          }.padding(.top, -50)
            
            // if they have no friends and friend requests
            if (friends.count == 0 && friendRequests.count == 0){
              
              Group {
                Text("You have no friends :(")
                Text("maybe send a friend request ;)")
              }
              .foregroundColor(Color("Gray - 400"))
              .font(.system(size: 22))
              
            }
            
            Spacer()
            
          }

          Spacer()
          
        }
      }
    }
}
