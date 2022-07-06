//
//  HostEventDetailsView.swift
//  Bouncr
//
//  Created by Sara Song on 7/6/22.
//

import SwiftUI

struct HostEventDetailsView: View {
  
    @EnvironmentObject var mainController: MainController
    @State private var isShowingScanner = false
    @State private var showPopUp: Bool = false
    @State private var showAlert = false
    var event: Event
    var ongoing: Bool
  
    //CONTINUE HERE...
  
    var body: some View {
        Text("HostEventDetailsView")
    }
}

