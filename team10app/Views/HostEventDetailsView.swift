//
//  HostEventDetailsView.swift
//  team10app
//
//  Created by GraceJoseph on 11/4/21.
//

import Foundation
import SwiftUI
import UIKit

struct HostEventDetailsView: View {
  
  @ObservedObject var viewModel = ViewModel()
  var event: Event
  var ongoing: Bool
  
  let columns = [GridItem(.fixed(100)), GridItem(.flexible())]
  let rows = [GridItem(.fixed(30))]
  let date: Date
  let dateStr: String
  let title: String
  
  init(event: Event, ongoing: Bool) {
    self.event = event
    self.ongoing = ongoing
    let timeInterval = TimeInterval(event.startTime)
    date = Date(timeIntervalSince1970: timeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, hh:mm a z"
    dateStr = dateFormatter.string(from: date)
    
    if (ongoing){
      self.title = event.name + " 🟢"
    }
    else {
      self.title = event.name
    }
    
  }
  
  var body: some View {
    
    VStack {
      
      VStack (alignment: .leading) {
        
        Text(dateStr)
          .foregroundColor(.white)
          .font(.system(size: 18))
        
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
          .padding(10)

          Spacer(minLength: 30)

        }.padding(.top, 10)
        
      }.frame(maxWidth: .infinity, minHeight: 120)
      .padding(.leading, 20)
      .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
      

    
    VStack(alignment: .leading) {
    
      LazyVGrid(columns: columns, alignment: .leading, spacing: 25) {
        
//        Text("Host(s): ")
//          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
//
//        Text("")
        
        Text("Location: ")
          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        
        Text("\(event.street1), \n\(event.city), \(event.state), \(event.zip)")
        
        if (event.description != nil){
            
          Text("About: ")
            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
          
          Text(event.description!)
          
        }
        
        Text("Guest List: ")
          .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        
        LazyHGrid(rows: rows, alignment: .lastTextBaseline) {
          
          // CHANGE DESTINATION TO BE THE ADD GUEST MODAL
          NavigationLink(destination: InvitationsView()) {
            
            VStack {
              
              //Below is code for the actual button
              ZStack {
                //The image of the 'plus' sign is on top
                
                Image(systemName: "plus")
                  .foregroundColor(Color.white)
                  .font(.subheadline)
                  
                }
                .frame(width: 25, height: 25)
                //Button is circular w/ blue-violet background
                .background(
                  ZStack {
                    Circle()
                      .fill(Color("Primary - Indigo"))
                  }
                )
                //Shadow under button
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
              .padding(.bottom, 1)
              
              Text("Add Guests")
                .font(.system(size: 10))
              
            }
            .frame(width: 60, height: 30, alignment: .center)
            
           
          }
          
          // for each guest invited should show a small circle with the first name under it
          // for v2 make it just the first 6 guests
          
          ForEach(0..<viewModel.indexEventGuests(eventKey: event.key).count, id: \.self){ index in
            
            VStack {
              
              ZStack {
                Circle()
                  .fill(Color("Primary - Indigo"))
              }
              
              Text(viewModel.indexEventGuests(eventKey: event.key)[index].firstName)
                .font(.system(size: 10))
            }
          }
          
        
        }.padding(.top, 30)

    }.padding(40)
      
      HStack (alignment: .center){
        
        
        Spacer()
        
        // CHANGE DESTINATION TO BE THE EDIT EVENT PAGE
        NavigationLink(destination: InvitationsView()){
          Text("Edit")
            .frame(width: 100, height: 30)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)), lineWidth: 1)
            )
            .padding(.bottom)
        }
        
        // OKAY THE DELETE ACTUALLY WORKS BUT ONLY WHEN YOU REPLACE THE BUILD BC IT NEEDS TO RELOAD
        NavigationLink(destination: InvitationsView()){ // isnt redirecting *cries* -g
          Button(action: {self.viewModel.eventInterface.delete(key: event.key)}, label: {
            Text("Delete")
              .frame(width: 100, height: 30)
              .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
              .foregroundColor(Color.white)
              .cornerRadius(10)
              .padding(.bottom)
          })
        }
        
        
        Spacer()
        
      }
        
    
      Spacer()
      
      
      .navigationBarTitle(title)
    }
  
  }
}
}
