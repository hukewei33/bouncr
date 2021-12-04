//
//  EventDetailsView.swift
//  team10app
//
//  Created by GraceJoseph on 10/30/21.
//

import Foundation
import SwiftUI
import UIKit

struct EventDetailsView: View {
  
  @EnvironmentObject var viewModel: ViewModel
  
  var event: Event;
//  let dayTimePeriodFormatter = DateFormatter();
//  dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a";
  
  let columns = [GridItem(.fixed(100)), GridItem(.flexible())]
  let startDate: Date
  let startDateStr: String
  let endDate: Date
  let endDateStr: String
  
  init(event: Event) {
    self.event = event
    let startTimeInterval = TimeInterval(event.startTime)
    startDate = Date(timeIntervalSince1970: startTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, h:mm a z"
    startDateStr = dateFormatter.string(from: startDate)
    let endTimeInterval = TimeInterval(event.endTime)
    endDate = Date(timeIntervalSince1970: endTimeInterval)
    endDateStr = dateFormatter.string(from: endDate)
  }
  
  var body: some View {
    
    let attendance = self.viewModel.getEventAttendence(eventKey: event.key)
    let attendingFriends = self.viewModel.getAttendingFriends(eventKey: event.key)
    
    VStack {
      
      VStack (alignment: .leading) {
        
        Text(startDateStr)
          .foregroundColor(.white)
          .font(.system(size: 18))
        
        HStack {

          // number of attendees currently checked in

          VStack (alignment: .center) {

            Text (String(attendance[0]) + " / " + String(attendance[1]))
              .fontWeight(.bold)
              .padding(.bottom, 4)
            Text ("checked in")

          }.foregroundColor(.white)

          Spacer()

          // number of friends invited

          VStack (alignment: .center) {

            Text (String(attendingFriends.count)) // placeholder
              .fontWeight(.bold)
              .padding(.bottom, 4)
            Text ("friends invited")

          }.foregroundColor(.white)
          .padding(10)

          Spacer(minLength: 30)

        }.padding(.top, 10)
        
      }.frame(maxWidth: .infinity, minHeight: 120)
      .padding(.leading, 20)
      .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
      

    
    VStack(alignment: .leading) {
    
      LazyVGrid(columns: columns, alignment: .leading, spacing: 25) {
        
        Text("Host: ")
          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        
        Text("")
        
        Text("Location: ")
          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        
        Text("\(event.street1), \n\(event.city), \(event.state), \(event.zip)")
        
        Text("Date/Time: ")
          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        
        Text(startDateStr) + Text(" to ") + Text(endDateStr)
        
        if !(event.description ?? "").isEmpty {
            
          Text("About: ")
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          
          Text(event.description!)
          
        }
        
        
      }

    }.padding(40)
    
    Spacer()
      .navigationBarTitle(event.name, displayMode: .large)
    }
    .navigationViewStyle(StackNavigationViewStyle())
   
  }
  
}
