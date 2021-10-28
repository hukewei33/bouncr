//
//  BottomNav.swift
//  team10app
//
//  Created by Sara Song on 10/27/21.
//

import SwiftUI

struct BottomNav: View {
  @ObservedObject var viewModel: ViewModel
  
  var body: some View {
    HStack {
      Spacer()
      
      Button(action: {} ) {
        VStack {
          Image(systemName: "calendar")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
          Text("Your Events")
        }
        //.foregroundColor(Color(red: 0.4627, green: 0.8392, blue: 1.0))
      }
      
      Spacer()
      
      Button(action: {} ) {
        VStack{
          Image(systemName: "envelope")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
          Text("Invitations")
        }
      }
        
      Spacer()
      
      Button(action: {} ) {
        VStack {
          Image(systemName: "person.crop.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
          Text("Profile")
        }
      }
      
      Spacer()
    }
    .padding()
  }
}

struct BottomNav_Previews: PreviewProvider {
    static var previews: some View {
        BottomNav(viewModel: ViewModel())
    }
}
