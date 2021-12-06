//
//  AddFriends.swift
//  team10app
//
//  Created by Sara Song on 12/3/21.
//
import SwiftUI

struct AddFriends: View {
  
  @EnvironmentObject var viewModel: ViewModel
  
  var body: some View {
    
    if (self.viewModel.getNonFriends().count > 0){
      
      List {
        ForEach(self.viewModel.getNonFriends(), id: \.self) { user in
          AddFriendsRow(user: user)
            .padding(10)
        }
        
      }
      .navigationTitle("Add Friends")
      
    } else {
      
      
      Text("You are friends with all of the users on this app! Congratulations!")
      .foregroundColor(Color("Gray - 400"))
      .font(.system(size: 22))
      .padding()
      
    }
    
    
  }
}
