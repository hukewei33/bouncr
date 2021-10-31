//
//  MoreDetailsButton.swift
//  team10app
//
//  Created by Sara Song on 10/31/21.
//

import SwiftUI

struct MoreDetailsButton: View {
  
  //Add some fields here for event id, will determine action of button
  
  var body: some View {
    Button(action: {print("Pressed More Details")}, label: {
      Text("More details")
        .font(.system(size: 15))
        .padding(10)
    })
    .frame(width: 300)
    .cornerRadius(10)
    .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)), lineWidth: 1)
    )
  }
}
