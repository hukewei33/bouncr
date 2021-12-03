////
////  AppView.swift
////  team10app
////
////  Created by Sara Song on 10/28/21.


import SwiftUI

struct AppView: View {
  
    @ObservedObject var viewModel: ViewModel
  
    var body: some View {
      
      if (viewModel.loggedin() == nil){
          LoginView(viewModel: viewModel)
      }
      else {
          TabView {
            //My Events page
            HostEventsView(viewModel: viewModel)
            .tabItem {
              Image(systemName: "calendar")
              Text("Your Events")
            }
            
            //Invitations Page
            InvitationsView(viewModel: viewModel)
            .tabItem {
              Image(systemName: "envelope")
              Text("Invitations")
            }
            
            // Profile Page
            ProfileView(user: User(firstName: "Dwight", lastName: "Schrute", email: "beets@schrutefarms.com", username: "assistantregionalmanager", profilePicURL: "", passwordHash: "examplepw1"))
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
