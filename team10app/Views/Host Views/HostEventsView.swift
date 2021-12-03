//
//  HostEventsView.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import SwiftUI

struct HostEventsView: View {
  
  @ObservedObject var viewModel: ViewModel
  
  //CITATION: The following code for changing top nav bar color comes from here:
  //https://levelup.gitconnected.com/cracking-the-navigation-bar-secrets-with-swiftui-30e9b019502c
    init(viewModel: ViewModel) {
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
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        ScrollView {
          VStack(alignment: .leading) {
            
            //Ongoing events
            if (viewModel.hostCurrentEvents.count>0) {
              Text("Ongoing Events")
                .bold()
                .font(.system(size: 22))
                .padding()
  //            ForEach(0..<self.viewModel.currentEvents.count, id: \.self) { index in
  //               HostOngoingEventCard(event: self.viewModel.currentEvents[index])
  //            }
                ForEach(self.viewModel.hostCurrentEvents, id: \.self) { event in
                  HostOngoingEventCard(viewModel: viewModel, event: event)
                }
            }
            
            //Upcoming events
            if (viewModel.hostEvents.count>0) {
              Text("Upcoming Events")
                .bold()
                .font(.system(size: 22))
                .padding()
//              ForEach(0..<self.viewModel.events.count, id: \.self) { index in
//                HostUpcomingEventCard(event: self.viewModel.events[index])
//              }
              //ForEach(colors, id: \.self) { color in
              ForEach(self.viewModel.hostEvents, id: \.self) { event in
                HostUpcomingEventCard(viewModel: viewModel, event: event)
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
          }
        }
        
        //Circular button in bottom right to add event
        VStack {
          Spacer()
          HStack {
            Spacer()
            NavigationLink(destination: CreateEventView(viewModel: viewModel)) {
              AddEventButton(viewModel: viewModel)
            }
          }
        }
        
      }
      .navigationTitle("Your Events")
      .navigationViewStyle(StackNavigationViewStyle())
    }
    .onAppear() {
          viewModel.indexHostEvents()
        }
  }
}
