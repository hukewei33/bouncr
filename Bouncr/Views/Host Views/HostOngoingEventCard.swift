//
//  HostOngoingEventCard.swift
//  Bouncr
//
//  Created by Sara Song on 7/9/22.
//

import SwiftUI
//import CodeScanner

struct HostOngoingEventCard: View {
  
  @State private var isShowingScanner = false
  @State private var showPopUp: Bool = false
  @State private var showAlert = false
  
  var event: Event
  let dateStr: String
  
  init(event: Event) {
    self.event = event
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, hh:mm a"
    dateStr = dateFormatter.string(from: event.startTime)
  }
  
    var body: some View {
      
//      let attendance = self.viewModel.getEventAttendence(eventKey: event.key) //HOW IS THIS IMPLEMENTED NOW?
      
      VStack {
        //Date & Time of ongoing event
        HStack {
          Text(dateStr)
            .bold()
            .font(.system(size: 12))
            .foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)))
          
          Spacer()
        }
        .padding([.top, .horizontal])
        
        //Event name, address, and scan QR button all in one row
        HStack {
          VStack(alignment: .leading) {
            HStack {
              Text(event.name)
                .font(.system(size: 28))
                .foregroundColor(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
                .padding(.bottom, 1)
                .lineLimit(1)
              Circle()
                .fill(Color(#colorLiteral(red: 0.262745098, green: 0.8784313725, blue: 0, alpha: 1)))
                .frame(width: 12, height: 12)
            }
            
            Text(event.street1)
              .font(.system(size: 17))
              .foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)))
              .lineLimit(1)
          }
          
          Spacer()
      
          //Button to scan QR Codes
          //CHANGE TO NAVIGATE TO QR CAMERA SCANNER VIEW!!
//          NavigationLink(destination: InvitationsView()) {
//            SquareScanQR()
//          }
          Button(action: {self.isShowingScanner = true}, label: {
            SquareScanQR()
          })
          .sheet(isPresented: $isShowingScanner) {
//            CodeScannerView(codeTypes: [.qr], completion: self.handleScan) //UNCOMMENT ONCE QR IMPLEMENTED AGAIN
            Text("PUT SCANNER VIEW BACK HERE LATER!!!")
          }
          
        }
        .padding(EdgeInsets(top: 2, leading: 15, bottom: 15, trailing: 15))
        
        /*
        UNCOMMENT ONCE ATTENDANCE IS FIGURED OUT
        Text (String(attendance[0]) + " / " + String(attendance[1]) + " guests checked in")
          .font(.system(size: 17))
          .padding(EdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 15))
        */
        
        //"More details" button
        MoreDetailsButton(event: event, ongoing: true)
        
      }
      
      .background(LinearGradient(gradient: Gradient(colors: [Color(red: 230/255, green: 239/255, blue: 1.0, opacity: 1), Color(red: 236/255, green: 233/255, blue: 1.0, opacity: 1)]), startPoint: .leading, endPoint: .trailing))
      .cornerRadius(10)
      .overlay(
          RoundedRectangle(cornerRadius: 10)
              .stroke(Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)), lineWidth: 1)
      )
      .padding([.bottom, .horizontal])

    }
  
  /*
   UNCOMMENT AND FIX
  func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    self.isShowingScanner = false
     
    switch result {
    case .success(let code):
      let details = code.components(separatedBy: "\n")
      print(details)
      guard details.count == 2 else { return }
      print(self.viewModel.invites)
      print(self.viewModel.invites.filter{$0.userKey == details[1] && $0.eventKey == details[0]})
      let inviteKey = self.viewModel.invites.filter{$0.userKey == details[1] && $0.eventKey == details[0]}[0].key;
      print(inviteKey)
      print(self.viewModel.checkin(inviteKey: inviteKey))
      print("success" + code)
    case .failure(let error):
      print("failure")
    }
  }
  */
}

