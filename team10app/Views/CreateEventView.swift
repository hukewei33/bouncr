//
//  CreateEventView.swift
//  team10app
//
//  Created by Sara Song on 11/2/21.
//

import SwiftUI

struct CreateEventView: View {
  
  @ObservedObject var viewModel: ViewModel
  @State private var name: String = ""
  @State private var date = Date()
  @State private var startTime = Date()
  @State private var endTime = Date()
  @State private var descr: String = ""
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        //Event Name field
        Text("Event Name *")
          .bold()
          .font(.system(size: 17))
        TextField(
          "Name",
          text: $name
        )
        .padding(.bottom, 30)
        
        //Event Date field
        Text("Event Date *")
          .bold()
          .font(.system(size: 17))
        DatePicker(
          "",
          selection: $date,
          displayedComponents: [.date]
        )
        .labelsHidden()
        .padding(.bottom, 30)
        
        //Start Time & End Time field
        HStack {
          //Start Time
          VStack(alignment: .leading) {
            Text("Start Time *")
              .bold()
              .font(.system(size: 17))
            DatePicker(
              "",
              selection: $startTime,
              displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
          }
          
          Spacer()
          
          //End Time
          VStack(alignment: .leading) {
            Text("End Time *")
              .bold()
              .font(.system(size: 17))
            DatePicker(
              "",
              selection: $endTime,
              displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
          }
        }
        .padding(.bottom, 30)
        
        //Event Description field
        Text("Event Description (optional)")
          .bold()
          .font(.system(size: 17))
        TextField(
          "Description",
          text: $descr
        )
        .padding(.bottom, 30)
        
        
        Spacer()
        
        HStack {
          Spacer()
          CreateEventFormSubmitButton()
        }
      }
      .padding(30)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      
    }
    .navigationTitle("New Event")
    

  }
}
