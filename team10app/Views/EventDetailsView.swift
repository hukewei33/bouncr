//
//  EventDetailsView.swift
//  team10app
//
//  Created by GraceJoseph on 10/30/21.
//

import Foundation
import SwiftUI

struct EventDetailsView: View {
  
  var event: Event;
//  let dayTimePeriodFormatter = DateFormatter();
//  dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a";
  
  var body: some View {
    
    // TOPBAR
      
      VStack(alignment: .leading) {

        // event name
        Text(event.name)
          .foregroundColor(.white)
          .fontWeight(.bold)
          .font(.system(size: 32))


        // event date + time
        
  //      Text(dayTimePeriodFormatter.stringFromDate( NSDate(timeIntervalSince1970: event.startTime)))
        Text(String(event.startTime))
            .foregroundColor(.white)
            .font(.system(size: 18))
        
        
        // STATISTICS TO BE IMPLEMENTED IN V2
          
        HStack {
          
          // number of attendees currently checked in
          
          VStack (alignment: .center) {
            
            Text ("# / #") // placeholder
              .fontWeight(.bold)
              .padding(.bottom, 4)
            Text ("checked in")
            
          }.foregroundColor(.white)
          
          Spacer()
          
          // number of friends invited
          
          VStack (alignment: .center) {
            
            Text ("#") // placeholder
              .fontWeight(.bold)
              .padding(.bottom, 4)
            Text ("friends invited")
            
          }.foregroundColor(.white)
          .padding(20)
          
          Spacer(minLength: 50)
          
        }.padding(.top, 10)

      }
        .frame(maxWidth: .infinity, minHeight: 180)
        .padding(.top, 100)
        .padding([.trailing, .leading], 40)
        .padding(.bottom, 20)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        .edgesIgnoringSafeArea(.top)
      
        
    VStack(alignment: .leading, spacing: 20) {
        
        HStack {
          
          Text("Host: ")
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          
          Spacer(minLength: 20)
          
          
        }
        
        HStack {
          
          Text("Location: ")
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          
          Spacer(minLength: 20)
          
          Text("\(event.street1), \n\(event.city), \(event.state), \(event.zip)")
            
        }
        
        HStack {
          
          Text("Date / Time: ")
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          
          Spacer(minLength: 20)
          
          Text(String(event.startTime) + " - " + String(event.endTime))
//          Text(dateFormatter.string(from: (Date(timeIntervalSinceReferenceDate: TimeInterval(Int(event.startTime))))
          
        }
        
        HStack {
          
          Text("About: ")
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          
          Spacer(minLength: 20)
          
          Text(event.description!)
          
        }
        
      }
    .padding([.leading, .trailing], 40)
    
    Spacer()
      
    .navigationBarHidden(true)
  }
  
}
