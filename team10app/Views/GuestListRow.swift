//
//  GuestListRow.swift
//  team10app
//
//  Created by Sara Song on 12/2/21.
//

import SwiftUI

struct GuestListRow: View {
  
  var guest: User
  
  var body: some View {
    VStack (alignment: .leading) {
      Group {
        Text("\(guest.firstName) \(guest.lastName)")
          .padding(.bottom)
        Text(guest.username)
          .foregroundColor(Color("Gray - 400"))
      }
      .padding()
    }
  }
}
