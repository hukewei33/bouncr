//
//  AddEventButton.swift
//  Bouncr
//
//  Created by Sara Song on 7/6/22.
//

import SwiftUI

struct AddEventButton: View {
  
  var body: some View {
  
    //Below is code for the actual button
    ZStack {
      //The image of the 'plus' sign is on top
      Image(systemName: "plus")
        .foregroundColor(Color.white)
        .font(.largeTitle)
    }
    .frame(width: 65, height: 65)
    //Button is circular w/ blue-violet background
    .background(
      ZStack {
        Circle()
          .fill(Color("Primary - Indigo"))
      }
    )
    //Shadow under button
    .shadow(color: Color.black.opacity(0.3),
            radius: 3,
            x: 3,
            y: 3)
    .padding()
  }

}
