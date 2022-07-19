//
//  EventForm.swift
//  Bouncr
//
//  Created by Sara Song on 7/19/22.
//

import SwiftUI

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
  
  
  var body: some View {
      Text("REPLACE THIS WHEN READY TO INCORPORATE")
  }
}

