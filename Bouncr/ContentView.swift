//
//  ContentView.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import SwiftUI

struct ContentView: View {
  
//  var viewModel = ViewModel()
  
  
  init() {
    
    // Customizations for the Top Navigation Bar
    UINavigationBar.appearance().backgroundColor = UIColor(red: 66/255, green: 0, blue: 255/255, alpha: 1.0);
    UINavigationBar.appearance().largeTitleTextAttributes =
      [ .foregroundColor: UIColor.white ]
    
    
  }
  
  
  var body: some View {
    VStack {
      AppView()
    }
//    .environmentObject(viewModel)
  }
}
