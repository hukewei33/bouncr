//
//  AddFriendsRow.swift
//  team10app
//
//  Created by Sara Song on 12/3/21.
//
import SwiftUI

struct AddFriendsRow: View {
  
  @EnvironmentObject var viewModel: ViewModel
  var user: User
  
  init(viewModel : ViewModel, user: User){
    self.viewModel = viewModel
    self.user = user
  }
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(user.firstName + " " + user.lastName)
        
        Text("@" + user.username)
          .foregroundColor(Color("Gray - 400"))
          .font(.system(size: 15))
      }
      
      Spacer()
      
      Button(action: {
        if let thisUser = viewModel.loggedin() {
          viewModel.addFriend(userKey1: thisUser, userKey2: user.key)
        }
      }, label: {
        Image(systemName: "person.badge.plus")
          .foregroundColor(Color.white)
          .frame(width: 40, height: 40)
      })
      .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
      .cornerRadius(10)
      .padding()
    }
  }
}
