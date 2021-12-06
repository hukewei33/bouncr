//
//  AppView.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.

import SwiftUI

struct AppView: View {
  

    @EnvironmentObject var viewModel: ViewModel
  
  init(viewModel: ViewModel){
    self.viewModel = viewModel
  }
  
    var body: some View {
      
      if (self.viewModel.loggedin() == nil){
        
        LoginView()
        
      }
      else {
        
          TabView {
            
            //My Events page
            HostEventsView()
            .tabItem {
              Image(systemName: "calendar")
              Text("Your Events")
            }
            
            
            //Invitations Page
            
            InvitationsView()
            .tabItem {
              Image(systemName: "envelope")
              Text("Invitations")
            }
            
            
            // Profile Page
            ProfileView()
            .tabItem {
              Image(systemName: "person.crop.circle")
              Text("Profile")
            }
      
          }
          .padding(.top)
          .onAppear() {
              //Fixes bug where tab bar was turning transparent on InvitationsView
              if #available(iOS 15.0, *) {
                  let appearance = UITabBarAppearance()
                  UITabBar.appearance().scrollEdgeAppearance = appearance
              }
              UITabBar.appearance().barTintColor = .white
          }
          .edgesIgnoringSafeArea(.top) //Makes top nav bar stretch all the way to top of device
        }
      
      }
}
