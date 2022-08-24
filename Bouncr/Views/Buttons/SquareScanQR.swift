//
//  SquareScanQR.swift
//  Bouncr
//
//  Created by Sara Song on 7/6/22.
//

import SwiftUI

struct SquareScanQR: View {
    var body: some View {
      
      ZStack {
        //The image of the qr icon is on top
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
