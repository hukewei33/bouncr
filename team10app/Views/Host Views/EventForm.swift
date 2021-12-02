//
//  EventForm.swift
//  team10app
//
//  Created by Sara Song on 12/2/21.
//

import SwiftUI
import Combine

struct EventForm: View {
  
  @ObservedObject var viewModel: ViewModel
  var optionalEvent: Event? //if nil, you're creating an event; if not, you're editing one
  var navTitle: String
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
  @State private var attendenceVisible = false
  @State private var friendsAttendingVisible = false
  
  // Had to use a function to init vars because @State vars can't be changes outside the body
  func initView() {
    if let event=self.optionalEvent {
      let startTimeInterval = TimeInterval(event.startTime)
      let endTimeInterval = TimeInterval(event.endTime)
      self.name = event.name
      startTime = Date(timeIntervalSinceReferenceDate: startTimeInterval)
      endTime = Date(timeIntervalSinceReferenceDate: endTimeInterval)
      street1 = event.street1
      if let s2 = event.street2 {
        street2 = s2 //optional
      }
      city = event.city
      state = event.state
      zip = event.zip
      if let eDescr = event.description {
        descr = eDescr //optional
      }
      attendenceVisible = event.attendenceVisible
      friendsAttendingVisible = event.friendsAttendingVisible
    }
  }
  
  //User can't create/edit event if any required fields are left blank
  var buttonDisabled: Bool {
    return (name.isEmpty || street1.isEmpty || city.isEmpty || state.isEmpty || zip.isEmpty)
  }

  //Submit button is a faded color if disabled
  var buttonColor: Color {
    return buttonDisabled ? Color("Disabled Button") : Color("Primary - Indigo")
  }
  
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
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        }
        
        //Event Date field
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
          
          //End Time Field
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
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        
        //Street2 field
          Text("Street 2 (optional)")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Street 2",
            text: $street2
          )
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
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
              .padding()
              .background(Color("Form Field Background"))
              .cornerRadius(10)
              .padding(.bottom, 30)
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
              .padding()
              .background(Color("Form Field Background"))
              .cornerRadius(10)
              .padding(.bottom, 30)
          }
        }
        
        //Zip field
        Group {
          Text("Zip Code *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Zip",
            text: $zip
          )
            .keyboardType(.numberPad)
            //CITATION: code to only allow numeric input: https://stackoverflow.com/questions/58733003/swiftui-how-to-create-textfield-that-only-accepts-numbers
            .onReceive(Just(zip)) { newValue in
              let filtered = newValue.filter { "0123456789".contains($0) }
              if (filtered != newValue) {
                  self.zip = filtered
              }
              //Zip code can only be 5 digits long
              if newValue.count > 5 {
                  self.zip.removeLast()
              }
            }
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
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
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        }
        
        //Toggles for attendence visibility permissions
        Group {
          Toggle(isOn: $attendenceVisible) {
            Text("Guestlist visible?")
              .bold()
              .font(.system(size: 17))
          }
          .padding(.bottom, 30)
          
          Toggle(isOn: $friendsAttendingVisible) {
            Text("# of friends invited visible?")
              .bold()
              .font(.system(size: 17))
          }
          .padding(.bottom, 30)
        }
        
        Spacer()
        
        //Submit button; Creates new event using viewModel
        HStack {
          Spacer()
          Button(action: {
            //Editing event, update existing event
            if let event=self.optionalEvent {
              print("Editing event...")
              viewModel.eventInterface.update(key: event.key,
                                              updateVals: ["name": name, "startTime": startTime.timeIntervalSinceReferenceDate,
                                                           "endTime": endTime.timeIntervalSinceReferenceDate, "street1": street1,
                                                           "street2": street2, "city": city, "zip": zip, "state": state, "description": descr,
                                                           "attendenceVisible": attendenceVisible, "friendsAttendingVisible": friendsAttendingVisible])
            }
            //Creating event, create new event
            else {
              viewModel.createEvent(name: name, startTime: startTime,
                                    endTime: endTime, street1: street1,
                                    street2: street2, city: city,
                                    zip: zip, state: state, description: descr,
                                    attendenceVisible: attendenceVisible,
                                    friendsAttendingVisible: friendsAttendingVisible)
            }
            viewModel.indexHostEvents()
            self.mode.wrappedValue.dismiss()
          }, label: {
            //Editing event button label:
            if self.optionalEvent != nil {
              Text("Save event")
                .bold()
                .foregroundColor(Color.white)
                .font(.system(size: 15))
                .padding(10)
            }
            //Creating event label:
            else {
              Text("Create event")
                .bold()
                .foregroundColor(Color.white)
                .font(.system(size: 15))
                .padding(10)
            }
          })
            .background(buttonColor)
            .cornerRadius(10)
            .disabled(buttonDisabled)
        }
      }
      .padding(30)
      .onAppear{ initView() }
    }
    .navigationTitle(self.navTitle)
    .navigationViewStyle(StackNavigationViewStyle())
  }
}


