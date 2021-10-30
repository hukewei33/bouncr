//
//  ProfileView.swift
//  team10app
//
//  Created by GraceJoseph on 10/29/21.
//

import Foundation
import SwiftUI
import UIKit
import Combine

struct ProfileView: View {
  
  var user: User
  
    var body: some View {
      
      
      
      VStack {

        // TOPBAR

        HStack {

          // need to still write code for profile pic here
          
          // if the profile pic is provided, display it
          if (user.profilePicURL != ""){
            
            
          }
          // otherwise use a default picture
          else {
            
            
            
          }
            

          VStack(alignment: .leading) {

            // display username
            Text("@" + user.username)
              .foregroundColor(.white)
              .font(.subheadline)


            // display name
            Text(user.firstName + " " + user.lastName)
              .foregroundColor(.white)
              .fontWeight(.bold)
              .font(.system(size: 24))

          }
          
          .padding()
          

        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))

        Spacer()

      }
            
    }
}
