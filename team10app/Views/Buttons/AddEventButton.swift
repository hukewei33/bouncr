//
//  AddEventButton.swift
//  team10app
//
//  Created by Sara Song on 10/31/21.
//

import SwiftUI

struct AddEventButton: View {
    var body: some View {
      VStack {
        Spacer()
        HStack {
          Spacer()
          //Add Event button
          Button(action: {print("Tapped Add Event Button")}, label: {
            Image(systemName: "plus")
              .foregroundColor(Color.white)
              .font(.largeTitle)
              .frame(width: 65, height: 65)
          })
          .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
          .cornerRadius(38.5)
          .padding()
          .shadow(color: Color.black.opacity(0.3),
                  radius: 3,
                  x: 3,
                  y: 3)
        }
      }
    }
}
