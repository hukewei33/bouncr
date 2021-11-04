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
  @State private var viewEventsHosted = true
  
    var body: some View {
    
      
      VStack {

        // TOPBAR

        HStack {

          // need to still write code for profile pic here
          
          // if the profile pic is provided, display it
          if (user.profilePicURL != ""){

            Image(uiImage: user.profilePicURL!.load())

          }
          // otherwise use a default picture
          else {

            Image(uiImage: "https://www.myany.city/sites/default/files/styles/scaled_cropped_medium__260x260/public/field/image/node-related-images/sample-dwight-k-schrute.jpg?itok=8TfRscbA".load())
              .resizable()
              .frame(width: 100, height: 100)
              .aspectRatio(contentMode: .fit)
              .cornerRadius(50)
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
        .padding(.top, 50)
        .padding(.bottom, 0)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        .edgesIgnoringSafeArea(.top)
        

        // SEGMENTED CONTROL
        
        Picker("List to View", selection: $viewEventsHosted){
          
          Text("Events Hosted").tag(true)
          Text("Events Attended").tag(false)
          
        }.pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: 300, alignment: .center)
        
        // list of events the user has hosted
        if (viewEventsHosted){
          
          List {
            
            
            
          }
          
          
        }
        // list of events the user has attended
        else {
          
          List {
            
            
            
          }
          
        }
        
        
        Spacer()

      }
      
            
    }
}
