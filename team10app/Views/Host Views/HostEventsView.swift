//
//  HostEventsView.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import SwiftUI

struct HostEventsView: View {
  
  @ObservedObject var viewModel: ViewModel
  var events: [Event]
  
  //CITATION: The following code for changing top nav bar color comes from here:
//  https://levelup.gitconnected.com/cracking-the-navigation-bar-secrets-with-swiftui-30e9b019502c
  init(viewModel: ViewModel, events: [Event]) {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    
    UINavigationBar.appearance().tintColor = .white
    
    self.viewModel = viewModel
    self.events = events
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        ScrollView {
          VStack(alignment: .leading) {
            //Ongoing events (TO BE IMPLEMENTED IN V2)
//            Text("Ongoing Events")
//              .bold()
//              .font(.system(size: 22))
//              .padding()
//            HostOngoingEventCard(event: self.viewModel.events[0])
            
            //Upcoming events
            Text("Upcoming Events")
              .bold()
              .font(.system(size: 22))
              .padding()
            ForEach(0..<self.viewModel.events.count, id: \.self) { index in
              HostUpcomingEventCard(event: self.viewModel.events[index])
            }
          }
        }
        
        //Circular button in bottom right to add event
        VStack {
          Spacer()
          HStack {
            Spacer()
            NavigationLink(destination: CreateEventView(viewModel: viewModel)) {
              AddEventButton()
            }
          }
        }
        
      }
      .navigationTitle("Your Events")
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
