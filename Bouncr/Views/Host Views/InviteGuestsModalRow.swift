//
//  InviteGuestsModalRow.swift
//  Bouncr
//
//  Created by Sara Song on 7/23/22.
//

import SwiftUI

struct InviteGuestsModalRow: View {
  @EnvironmentObject var mainController: MainController
  var user: OtherUser
  let width = UIScreen.main.bounds.width * 0.25
  @State var isChecked: Bool = false
  @Binding var checkedUsers: [OtherUser]
  
  init(user: OtherUser, checkedUsers: Binding<[OtherUser]>){
    self.user = user
    self._checkedUsers = checkedUsers
  }
 
  func toggleCheckBox() {
    isChecked = !isChecked
    if (isChecked) {
      self.checkedUsers.append(user)
    }
    else {
      self.checkedUsers = self.checkedUsers.filter { $0.id != user.id }
    }
  }
  
  var body: some View {
    HStack {
      Text(user.firstName + " " + user.lastName)
      
      Spacer()
      
      Button(action: {toggleCheckBox()}){
        Image(systemName: isChecked ? "checkmark.square": "square")
      }
    }
  }
}
