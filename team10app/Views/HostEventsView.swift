//
//  HostEventsView.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import SwiftUI

struct HostEventsView: View {
  
  //CITATION: The following code for changing top nav bar color comes from here:
  //https://levelup.gitconnected.com/cracking-the-navigation-bar-secrets-with-swiftui-30e9b019502c
  init() {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    
    UINavigationBar.appearance().tintColor = .white
  }
  
  var body: some View {
    NavigationView {
      Text("Cards here")
        .navigationTitle("Your Events")
    }
  }
}

struct HostEventsView_Previews: PreviewProvider {
    static var previews: some View {
        HostEventsView()
    }
}
