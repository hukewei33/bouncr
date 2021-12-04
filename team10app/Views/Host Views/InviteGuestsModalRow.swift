//
//  InviteGuestsModalRow.swift
//  team10app
//
//  Created by Sara Song on 11/4/21.
//

import SwiftUI

//CITATION: Incorporated code for checkbox from: https://makeapppie.com/2019/10/16/checkboxes-in-swiftui/
struct InviteGuestsModalRow: View {
  
  @EnvironmentObject var viewModel: ViewModel
  var user: User
  let width = UIScreen.main.bounds.width * 0.25
  @State var isChecked: Bool = false
 
  func toggleCheckBox() {
    isChecked = !isChecked
    if (isChecked) {
      self.viewModel.addPotentialInvite(user: self.user)
    }
    else {
      self.viewModel.removePotentialInvite(user: self.user)
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
