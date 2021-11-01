//
//  AppView.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import SwiftUI

struct AppView: View {
    var body: some View {
      TabView {
        //My Events page
        Text("Replace this Text() w/ host page")
        .tabItem {
          Image(systemName: "calendar")
          Text("Your Events")
        }
        
        //Invitations Page
        Text("Replace this Text() w/ attendee page")
        .tabItem {
          Image(systemName: "envelope")
          Text("Invitations")
        }
        
        Text("Replace this Text() w/ profile page")
        .tabItem {
          Image(systemName: "person.crop.circle")
          Text("Profile")
        }
      }
      .padding(.top)
      .onAppear() {
          UITabBar.appearance().barTintColor = .white
        
      }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
