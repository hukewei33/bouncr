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
  @ObservedObject var viewModel = ViewModel()
//  @State private var viewFriendRequests = true
  
    var body: some View {
    
      
      VStack {

        // TOPBAR

        HStack {

          // need to still write code for profile pic here
          
          
          // use a default if null
          if (user.profilePicURL == nil || user.profilePicURL == ""){

            Image(uiImage: "https://www.myany.city/sites/default/files/styles/scaled_cropped_medium__260x260/public/field/image/node-related-images/sample-dwight-k-schrute.jpg?itok=8TfRscbA".load())
              .resizable()
              .frame(width: 100, height: 100)
              .aspectRatio(contentMode: .fit)
              .cornerRadius(50)

          }
          // display the non-nil profile pic
          else {
            
            Image(uiImage: user.profilePicURL!.load())
              .resizable()
              .frame(width: 100, height: 100)
              .aspectRatio(contentMode: .fit)
              .cornerRadius(50)
            
          }
          
          

          VStack(alignment: .leading) {

            // display username
            Text("@" + user.username)
              .foregroundColor(.white)
              .font(.subheadline)


            // display name
            Text(user.firstName + " " + user.lastName)
              .foregroundColor(.white)
              .fontWeight(.bold)
              .font(.system(size: 24))

          }
          
          .padding()
          

        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .padding(.top, 50)
        .padding(.bottom, 0)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        .edgesIgnoringSafeArea(.top)
        

//        // SEGMENTED CONTROL
//
//        Picker("List to View", selection: $viewFriendRequests){
//
//          Text("Friends").tag(true)
//          Text("Past Events").tag(false)
//
//        }.pickerStyle(SegmentedPickerStyle())
//        .frame(maxWidth: 300, alignment: .center)
        
        // list of friend request the user must respond to
        if (self.viewModel.thisUser != nil){
          
          List {
            
//            Section(header: Text("Friend Requests")){
              
            ForEach(0..<self.viewModel.pendingFriends.filter{$0.userKey1 == self.viewModel.thisUser!.key}.count, id: \.self) { index in
                
              Text(
                self.viewModel.users.filter{$0.key == self.viewModel.pendingFriends[index].userKey2}[0].firstName)
                  
              }
            
            
          }
          
          
        }
        
        Spacer()
        
      }
        
    }
}
