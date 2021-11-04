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
        Text("Start Date and Time *")
          .bold()
          .font(.system(size: 17))
        DatePicker(
          "",
          selection: $startTime,
          displayedComponents: [.date, .hourAndMinute]
        )
        .labelsHidden()
        .padding(.bottom, 30)
          
        //End Time Field
        Text("End Time *")
          .bold()
          .font(.system(size: 17))
        DatePicker(
          "",
          selection: $endTime,
          displayedComponents: [.hourAndMinute]
        )
        .labelsHidden()
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
          Button(action: {print($name, $startTime, $endTime, $descr)}, label: {
            Text("Create event")
              .bold()
              .foregroundColor(Color.white)
              .font(.system(size: 15))
              .padding(10)
          })
            .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
            .cornerRadius(10)
        }
      }
      .padding(30)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      
    }
    .navigationTitle("New Event")
    

  }
}
