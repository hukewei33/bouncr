//
//  ContentView.swift
//  team10app
//
//  Created by Kenny Hu on 10/19/21.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = ViewModel()
  
  var body: some View {
    VStack {
      //BottomNav(viewModel: viewModel)
      AppView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
