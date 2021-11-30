//
//  CreateEventView.swift
//  team10app
//
//  Created by Sara Song on 11/2/21.
//

import SwiftUI

struct CreateEventView: View {
  
  @ObservedObject var viewModel: ViewModel
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  @State private var name: String = ""
  @State private var startTime = Date()
  @State private var endTime = Date()
  @State private var street1: String = ""
  @State private var street2: String = "" //optional
  @State private var city: String = ""
  @State private var state: String = ""
  @State private var zip: String = ""
  @State private var descr: String = "" //optional
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        //Event Name field
        Group {
          Text("Event Name *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Name",
            text: $name
          )
          .padding(.bottom, 30)
        }
        
        //Start Date/Time field
        Group {
          Text("Start Date & Time *")
            .bold()
            .font(.system(size: 17))
          DatePicker(
            "",
            selection: $startTime,
            displayedComponents: [.date, .hourAndMinute]
          )
          .labelsHidden()
          .padding(.bottom, 30)
        }
        
        //End Date/Time Field
        Group {
          Text("End Date & Time *")
            .bold()
            .font(.system(size: 17))
          DatePicker(
            "",
            selection: $endTime,
            displayedComponents: [.date, .hourAndMinute]
          )
          .labelsHidden()
          .padding(.bottom, 30)
        }
        
        //Street1 field
        Group {
          Text("Street 1 *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Street 1",
            text: $street1
          )
          .padding(.bottom, 30)
        
        //Street2 field
          Text("Street 2 (optional)")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Street 2",
            text: $street2
          )
          .padding(.bottom, 30)
        }
        
        //City field
        HStack {
          VStack(alignment: .leading) {
            Text("City *")
              .bold()
              .font(.system(size: 17))
            TextField(
              "City",
              text: $city
            )
          }
        
        
          //State field
          VStack(alignment: .leading) {
            Text("State *")
              .bold()
              .font(.system(size: 17))
            TextField(
              "State",
              text: $state
            )
          }
        }
        .padding(.bottom, 30)
        
        //Zip field
        Group {
          Text("Zip Code *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Zip",
            text: $zip
          )
          .padding(.bottom, 30)
        }
        
        //Event Description field
        Group {
          Text("Event Description (optional)")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Description",
            text: $descr
          )
          .padding(.bottom, 30)
        }
        
        Spacer()
        
        //Submit button; Creates new event using viewModel
        HStack {
          Spacer()
          Button(action: {viewModel.createEvent(name: name, startTime: startTime,
                                                endTime: endTime, street1: street1,
                                                street2: street2, city: city,
                                                zip: zip, state: state, description: descr,
                                                attendenceVisible: true, friendsAttendingVisible: false)
                          self.mode.wrappedValue.dismiss()
          }, label: {
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
    
    .navigationViewStyle(StackNavigationViewStyle())
  }
}
