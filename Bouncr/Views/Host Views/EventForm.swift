//
//  EventForm.swift
//  Bouncr
//
//  Created by Sara Song on 7/19/22.
//

import SwiftUI
import Combine

struct EventForm: View {
  
  
  //List of US States for the State picker field
  let states = [ "AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA",
                 "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD",
                 "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH",
                 "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC",
                 "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"]
  
  @EnvironmentObject var mainController: MainController
  var optionalEvent: Event? //if nil, you're creating an event; if not, you're editing one
  var navTitle: String
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  init(optionalEvent: Event? = nil, navTitle: String){
    self.optionalEvent = optionalEvent
    self.navTitle = navTitle
  }
  
  @State private var name: String = ""
  @State private var startTime = Date()
  @State private var endTime = Date()
  @State private var street1: String = ""
  @State private var street2: String = "" //optional
  @State private var city: String = ""
  @State private var state: String = ""
  @State private var zip: String = ""
  @State private var descr: String = "" //optional
  @State private var attendenceVisible: Bool = false
  @State private var friendsAttendingVisible: Bool = false
  
  // Had to use a function to init vars because @State vars can't be changed outside the body
  func initView() {
    if let event=self.optionalEvent {
      self.name = event.name
      startTime = event.startTime
      endTime = event.endTime
      street1 = event.street1
      if let s2 = event.street2 {
        street2 = s2 //optional
      }
      city = event.city
      state = event.state
      zip = String(event.zip)
      //if zip had 0 at front, 0's wouldn't be there since zip is int in DB...put back 0's here
      if zip.count<5 {
        for _ in 1...(5-zip.count) {
          zip = "0" + zip
        }
      }
      if let eDescr = event.description {
        descr = eDescr //optional
      }
      attendenceVisible = event.attendenceVisible
      friendsAttendingVisible = event.friendsAttendingVisible
    }
    else {
      endTime = startTime.addingTimeInterval(300)
    }
  }
  
  //User can't create/edit event if any required fields are left blank
  var buttonDisabled: Bool {
    let invalidZip = zip.isEmpty || zip.count != 5
    return (name.isEmpty || street1.isEmpty || city.isEmpty || state.isEmpty || invalidZip)
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
            in: Date()...,
            displayedComponents: [.date, .hourAndMinute]
          )
          .labelsHidden()
          .padding(.bottom, 30)
          //Make sure that when startdate changes to be later than enddate, enddate is automatically updated
          .onChange (of: startTime) { date in
            if (endTime<=startTime) {
              endTime = startTime.addingTimeInterval(300)
            }
          }
          
          //End Time Field
          Text("End Date & Time *")
            .bold()
            .font(.system(size: 17))
          DatePicker(
            "",
            selection: $endTime,
            in: startTime.addingTimeInterval(300)...,
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
            Picker("Please pick a state", selection: $state) {
              //Have an item in the picker for an empty input:
              Text("---").tag("")
                .foregroundColor(Color("Gray - 400"))
              //Loop thru states list for each item in Picker
              ForEach(states, id: \.self) {
                  Text($0)
              }
            }
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
              print("EDITING EVENT...")
              let newEvent=Event(id: event.id, name: name, startTime: startTime, endTime: endTime, street1: street1, street2: street2, city: city, state: state, zip: Int(zip)!, description: descr, attendenceVisible: attendenceVisible, friendsAttendingVisible: friendsAttendingVisible, attendenceCap: event.attendenceCap, coverCharge: event.coverCharge, isOpenInvite: event.isOpenInvite, venueLatitude: event.venueLatitude, venueLongitude: event.venueLongitude, organizations: event.organizations, acceptedInvitesCount: event.acceptedInvitesCount, checkedInInvitescount: event.checkedInInvitescount)
              mainController.hostedEventController.updateEvent(updatedEvent: newEvent){mainController.hostedEventController.getHostedEvents()}
            }
            //Creating event, create new event
            else {
              print("CREATING EVENT...")
              //Note: id doesn't matter, so set it to random hardcoded value
              //NEED TO CHANGE OTHER HARDCODED VALUES LATER!!!!!
              let newEvent=Event(id: 42, name: name, startTime: startTime, endTime: endTime, street1: street1, street2: street2, city: city, state: state, zip: Int(zip)!, description: descr, attendenceVisible: attendenceVisible, friendsAttendingVisible: friendsAttendingVisible, attendenceCap: 1000, coverCharge: 10, isOpenInvite: false, venueLatitude: 0, venueLongitude: 0, organizations: [], acceptedInvitesCount: 0, checkedInInvitescount: 0)
              mainController.hostedEventController.createEvent(newEvent: newEvent){mainController.hostedEventController.getHostedEvents()}
              self.mode.wrappedValue.dismiss()
            }
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
      } //End VStack
      .padding(30)
      .onAppear{ initView() }
    } //End ScrollView
    .navigationTitle(self.navTitle)
    .navigationViewStyle(StackNavigationViewStyle())
  }//End var body: some View
}

