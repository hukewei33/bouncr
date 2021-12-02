//
//  GuestList.swift
//  team10app
//
//  Created by Sara Song on 12/2/21.
//

import SwiftUI

struct GuestList: View {
  
  @ObservedObject var viewModel = ViewModel()
  var event: Event

  var body: some View {
    List {
      ForEach(0..<self.viewModel.indexEventGuests(eventKey: event.key).count, id: \.self) { index in
        GuestListRow(guest: self.viewModel.indexEventGuests(eventKey: event.key)[index])
      }
    }
  }
}
