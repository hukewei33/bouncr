//
//  AppView.swift
//  Bouncr
//
//  Created by Sara Song on 6/30/22.
//


import SwiftUI

struct AppView: View {
  
    @EnvironmentObject var mainController: MainController
  
    var body: some View {
      
      if (!self.mainController.loggedin()){
        
        LoginView()
        
      }
      else {
        
          TabView {
            
            //My Events page
//            HostEventsView()
            Text("HostEventsView")
            .tabItem {
              Image(systemName: "calendar")
              Text("Your Events")
            }
            
            
            //Invitations Page
//            InvitationsView()
            Text("InvitationsView")
            .tabItem {
              Image(systemName: "envelope")
              Text("Invitations")
            }
            
            
            // Profile Page
//            ProfileView()
            Text("ProfileView")
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
