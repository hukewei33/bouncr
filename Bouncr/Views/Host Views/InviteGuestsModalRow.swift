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
  
  init(user: OtherUser){
    self.user = user
  }
 
  func toggleCheckBox() {
    isChecked = !isChecked
    if (isChecked) {
      //PUT BACK CODE ONCE YOU FIGURE OUT HOW TO IMPLEMENT THIS
//      self.viewModel.addPotentialInvite(user: self.user)
    }
    else {
//      self.viewModel.removePotentialInvite(user: self.user)
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
