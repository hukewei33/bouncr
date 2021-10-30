//
//  HostEventsView.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import SwiftUI

struct HostEventsView: View {
  
  init() {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = .systemBlue
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
