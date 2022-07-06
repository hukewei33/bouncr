//
//  HostEventsView.swift
//  Bouncr
//
//  Created by Sara Song on 7/6/22.
//

import SwiftUI

struct HostEventsView: View {
  
  @EnvironmentObject var mainController: MainController
  
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
      ZStack {
        ScrollView {
          VStack(alignment: .leading) {
            
            //Ongoing events
            /*
            if (viewModel.hostCurrentEvents.count>0) {
              Text("Ongoing Events")
                .bold()
                .font(.system(size: 22))
                .padding()
              ForEach(self.viewModel.hostCurrentEvents, id: \.self) { event in
                HostOngoingEventCard(event: event)
              }
            }
             
            
            //Upcoming events
            if (viewModel.hostEvents.count>0) {
              Text("Upcoming Events")
                .bold()
                .font(.system(size: 22))
                .padding()
              ForEach(self.viewModel.hostEvents, id: \.self) { event in
                HostUpcomingEventCard(event: event)
              }
            }
            
            //Display placeholder text if no events at all
            if (viewModel.hostEvents.count==0 && viewModel.hostCurrentEvents.count==0) {
              Spacer()
              Text("You are not hosting any events")
                .foregroundColor(Color("Gray - 400"))
                .font(.system(size: 22))
                .padding()
              Spacer()
            }
             */
          }
        }
        
        //Circular button in bottom right to add event
        VStack {
          Spacer()
          HStack {
            Spacer()
            //NavigationLink(destination: EventForm(navTitle: "New Event")) {
              AddEventButton()
            //}
          }
        }
        
      }
      .navigationTitle("Your Events")
      .navigationViewStyle(StackNavigationViewStyle())
    }
    /*
    .onAppear() {
          viewModel.indexHostEvents()
    }
     */
  }
}
