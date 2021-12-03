//
//  AddFriends.swift
//  team10app
//
//  Created by Sara Song on 12/3/21.
//
import SwiftUI

struct AddFriends: View {
  
  @ObservedObject var viewModel: ViewModel
  
  var body: some View {
    List {
      ForEach(self.viewModel.getNonFriends(), id: \.self) { user in
        AddFriendsRow(viewModel: self.viewModel, user: user)
          .padding(10)
      }
      
    }
    .navigationTitle("Add Friends")
  }
}
