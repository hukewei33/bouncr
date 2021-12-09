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
  
  let rows = [GridItem(.fixed(30))]
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
    let hosts = self.viewModel.hosts.filter{$0.eventKey == event.key}[0].userKey
    
    VStack {
      
      VStack (alignment: .leading) {
        
        HStack {
          Text(event.name)
            .bold()
            .font(.system(size: 32))
            .foregroundColor(.white)

            .padding(.top, 10)
            .padding(.bottom, 5)
            .lineLimit(1)
          
          if (viewModel.currentEvents.filter{$0.key == event.key}.count > 0){
            Circle()
              .fill(Color(#colorLiteral(red: 0.262745098, green: 0.8784313725, blue: 0, alpha: 1)))
              .frame(width: 12, height: 12)
          }
          else {
            Spacer()
          }
          
        } .padding(.leading, 20)

        
        Text(startDateStr)
          .foregroundColor(.white)
          .font(.system(size: 18))
          .padding(.leading, 20)
        
        HStack {
          
          Spacer(minLength: 30)

          // number of attendees currently checked in

          VStack (alignment: .center) {

            Text (String(attendance[0]) + " / " + String(attendance[1]))
              .fontWeight(.bold)
              .padding(.bottom, 4)
            Text ("checked in")

          }.foregroundColor(.white)

          Spacer(minLength: 30)

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
     
      .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
      

    
    VStack(alignment: .leading) {
    
      LazyVGrid(columns: columns, alignment: .leading, spacing: 25) {
        
        Text("Host: ")
          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        
        Text("@" + self.viewModel.users.filter{$0.key == hosts}[0].username)
          .lineLimit(1)
        
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
        
        if (event.attendenceVisible && viewModel.indexEventGuests(eventKey: event.key).count > 0){
            
          Text("Guests: ")
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          
          LazyHGrid(rows: rows, alignment: .lastTextBaseline) {
            
            // add see more button
            if (viewModel.indexEventGuests(eventKey: event.key).count > 4){
              
              // for each guest invited should show a small circle with the first name under it
              ForEach(0..<3, id: \.self){ index in

                VStack {
                  
                  if (viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == nil || viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == ""){

                    Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
                      .resizable()
                      .frame(width: 30, height: 30)
                      .aspectRatio(contentMode: .fit)
                      .cornerRadius(15)

                  }
                  // display the non-nil profile pic
                  else {
                    
                    Image(uiImage: viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL!.load())
                      .resizable()
                      .frame(width: 30, height: 30)
                      .aspectRatio(contentMode: .fit)
                      .cornerRadius(15)
                  }

                  Text(viewModel.indexEventGuests(eventKey: event.key)[index].firstName)
                    .font(.system(size: 10))
                  
                }.frame(width: 50)
              }
              
              // see more button!
              VStack {
                
                NavigationLink(destination: GuestList(event: event, guestHost: "guest")){
                  Image(systemName: "ellipsis")
                     .foregroundColor(Color.white)
                     .frame(width: 30, height: 30)
                }
                  .background(Color(.gray))
                 .cornerRadius(38.5)
                 .shadow(color: Color.black.opacity(0.3),
                         radius: 3,
                         x: 3,
                         y: 3)

                 Text("See More")
                   .font(.system(size: 10))

               }
              .padding(.top, 2.5)
               .frame(width: 50, height: 50, alignment: .center)

            }
            // show all 4 guests
            else {
              
              // for each guest invited should show a small circle with the first name under it
              ForEach(0..<viewModel.indexEventGuests(eventKey: event.key).count, id: \.self){ index in

                VStack {
                  if (viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == nil || viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == ""){

                    Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
                      .resizable()
                      .frame(width: 30, height: 30)
                      .aspectRatio(contentMode: .fit)
                      .cornerRadius(15)

                  }
                  // display the non-nil profile pic
                  else {
                    Image(uiImage: viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL!.load())
                      .resizable()
                      .frame(width: 30, height: 30)
                      .aspectRatio(contentMode: .fit)
                      .cornerRadius(15)
                  }

                  Text(viewModel.indexEventGuests(eventKey: event.key)[index].firstName)
                    .font(.system(size: 10))
                  
                }.frame(width: 50)
              } // End ForEach
              
            } //end else
            
          } //end lazyHGrid
          
        } //end if
        
      } //end LazyVGrid

    }.padding(40)
    
    Spacer()
    .navigationBarTitleDisplayMode(.inline)
    }
    .navigationViewStyle(StackNavigationViewStyle())
   
  }
  
}
