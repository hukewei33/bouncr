//
//  CreateEventFormSubmitButton.swift
//  team10app
//
//  Created by Sara Song on 11/2/21.
//

import SwiftUI

struct CreateEventFormSubmitButton: View {
  var body: some View {
    Button(action: {print("pressed submit button")}, label: {
      Text("Create event")
        .bold()
        .foregroundColor(Color.white)
        .font(.system(size: 15))
        .padding(10)
    })
      .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
      .cornerRadius(10)

  }
}

