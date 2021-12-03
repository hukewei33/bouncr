//
//  SquareScanQR.swift
//  team10app
//
//  Created by Sara Song on 10/31/21.
//

import SwiftUI

struct SquareScanQR: View {
    var body: some View {
      
      // NavigationLink(destination: InvitationsView()){
      //   Image(systemName: "qrcode.viewfinder")
      //     .foregroundColor(Color.white)
      //     .font(.largeTitle)
      //     .frame(width: 60, height: 60)
      // }
      // .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
      // .cornerRadius(10)
      // .padding()

      //Below is code for the actual button
      ZStack {
        //The image of the 'plus' sign is on top
        Image(systemName: "qrcode.viewfinder")
          .foregroundColor(Color.white)
          .font(.largeTitle)
      }
      .frame(width: 60, height: 60)
      .background(
        ZStack {
          Rectangle()
            .fill(Color("Primary - Indigo"))
        }
        .cornerRadius(10)
      )
    }
}
