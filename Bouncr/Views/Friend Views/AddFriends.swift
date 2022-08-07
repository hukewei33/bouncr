//
//  AddFriends.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/6/22.
//

import SwiftUI

struct AddFriends: View {
    @EnvironmentObject var mainController: MainController
    @ObservedObject var otherUserController: OtherUserController
    
    init(otherUserController: OtherUserController){
        self.otherUserController=otherUserController
    }
    
    func populateNonFriendSearch(term: String){
        
    }
      
      var body: some View {
        
        Text("TODO")
          
//          List {
//            ForEach(self.viewModel.getNonFriends(), id: \.self) { user in
//              AddFriendsRow(user: user)
//                .padding(10)
//            }
//
//          }
//          .navigationTitle("Add Friends")
          
        
      }


}
