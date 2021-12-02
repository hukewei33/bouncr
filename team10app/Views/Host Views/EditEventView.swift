//
//  EditEventView.swift
//  team10app
//
//  Created by Sara Song on 11/5/21.
//

import SwiftUI

struct EditEventView: View {
  
  @ObservedObject var viewModel: ViewModel
  var event: Event
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
  
  // Had to use a function to init vars because @State vars can't be changes outside the body
  func initView() {
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
        
        Spacer()
        
        //Submit button; Creates new event using viewModel
        HStack {
          Spacer()
          Button(action: {viewModel.eventInterface.update(key: self.event.key, updateVals: ["name": name, "startTime": startTime.timeIntervalSinceReferenceDate,"endTime": endTime.timeIntervalSinceReferenceDate, "street1": street1, "street2": street2, "city": city,"zip": zip, "state": state, "description": descr])
                          self.mode.wrappedValue.dismiss()
          }, label: {
            Text("Save event")
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
      .onAppear{ initView() }
    }
    .navigationTitle("Edit Event")
    
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

