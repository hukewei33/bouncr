//
//  HostEventDetailsView.swift
//  Bouncr
//
//  Created by Sara Song on 7/6/22.
//


import Foundation
import SwiftUI
import UIKit
//import CodeScanner

struct HostEventDetailsView: View {
  
  @EnvironmentObject var mainController: MainController
  @State private var isShowingScanner = false
  @State private var showPopUp: Bool = false
  @State private var showAlert = false
  var event: Event
  var ongoing: Bool
  
  let columns = [GridItem(.fixed(100)), GridItem(.flexible())]
  let rows = [GridItem(.fixed(30))]
  let startDateStr: String
  let endDateStr: String
  
  init(event: Event, ongoing: Bool) {
    self.event = event
    self.ongoing = ongoing
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, h:mm a z"
    startDateStr = dateFormatter.string(from: event.startTime)
    endDateStr = dateFormatter.string(from: event.endTime)
    
  }
  
  var body: some View {
    
    ZStack {
      
      VStack {
        
        VStack (alignment: .leading) {
          
          HStack {
            Text(event.name)
              .bold()
              .font(.system(size: 32))
              .foregroundColor(.white)

              .padding(.top, 10)
              .padding(.bottom, 5)
              .lineLimit(1)
            
            if (ongoing){
              Circle()
                .fill(Color(#colorLiteral(red: 0.262745098, green: 0.8784313725, blue: 0, alpha: 1)))
                .frame(width: 12, height: 12)
            }
            
            Spacer()
            
          }.padding(.leading, 10)
          
          Text(startDateStr)
            .foregroundColor(.white)
            .font(.system(size: 18))
            .padding(.leading, 10)
          
          /*
           PUT BACK ONCE ATTENDANCE IS FIGURED OUT
          if (ongoing){
            
            HStack {
              
              // number of attendees currently checked in
              VStack (alignment: .center) {
                Text (String(attendance[0]) + " / " + String(attendance[1]))
                  .fontWeight(.bold)
                  .padding(.bottom, 2)
                Text ("checked in")
                  .bold()
              }
              .foregroundColor(.white)
              
              Spacer()
            }
            .padding([.vertical], 10)
            .padding(.leading, 20)
            
          }
           */
        }
        .padding(.leading, 10)
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        
        

        VStack(alignment: .leading) {
        
          LazyVGrid(columns: columns, alignment: .leading, spacing: 25) {
            
            Text("Location: ")
              .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            
            Text("\(event.street1), \n\(event.city), \(event.state), \(String(event.zip))")
            
            Text("Date/Time: ")
              .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            
            Text(startDateStr) + Text(" to ") + Text(endDateStr)
            
            if !(event.description ?? "").isEmpty {
                
              Text("About: ")
                .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
              
              Text(event.description!)
              
            }
            
            //Guest Attendance Bubbles
            PendingGuestsBubbles(otherUserController: mainController.otherUserController, event: event, showInviteModal: $showPopUp)
            
            AttendingGuestsBubbles(otherUserController: mainController.otherUserController, event: event)
            
          }//End LazyVGrid
          .padding([.leading, .trailing, .bottom], 30)
          .padding(.top, 10)

          VStack {
            
            HStack (alignment: .center){
              
              Spacer()
              
              //Edit event button
              NavigationLink(destination: EventForm(optionalEvent: self.event, navTitle: "Edit Event")){
                Text("Edit")
                  .frame(width: 100, height: 30)
                  .background(Color.white)
                  .cornerRadius(10)
                  .overlay(
                      RoundedRectangle(cornerRadius: 10)
                          .stroke(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)), lineWidth: 1)
                  )
                  .padding(.bottom)
              }//End NavigationLink
              
              //Delete button, shows alert for confirmation before deleting an event
              Button(action: {showAlert = true}, label: {
                Text("Delete")
                  .frame(width: 100, height: 30)
                  .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
                  .foregroundColor(Color.white)
                  .cornerRadius(10)
                  .padding(.bottom)
              })
                .alert(isPresented: $showAlert) {
                  Alert(
                    title: Text("Delete " + event.name + "?"),
                    message: Text("You won't be able to undo this"),
                    primaryButton: .default(
                      Text("Cancel")
                    ),
                    secondaryButton: .destructive(
                      Text("Delete"),
                      action: {
                        self.mainController.hostedEventController.deleteEvent(deletedEventID: event.id){mainController.hostedEventController.getHostedEvents()}
                        //navigate back to host events index page?
                      }
                    )
                  )
                }
              
              Spacer()
              
            }

            // SquareScanQR()
            if (ongoing) {
              Button(action: {self.isShowingScanner = true}, label: {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan Invites")
              })
              .sheet(isPresented: $isShowingScanner) {
                //CodeScannerView(codeTypes: [.qr], completion: self.handleScan)//UNCOMMENT ONCE QR IMPLEMENTED AGAIN
                Text("PUT SCANNER VIEW BACK HERE LATER!!!")
              }
            }//End HStack
          }//End VStack

          Spacer()
            .navigationBarTitleDisplayMode(.inline)

        }//End VStack
        .navigationViewStyle(StackNavigationViewStyle())
      }//End VStack
        
      InviteGuestsModal(show: $showPopUp, event: self.event, otherUserController: mainController.otherUserController)
    }//End ZStack
    .onAppear() {
      mainController.otherUserController.getAllGuests(eventID: event.id)
    }
  }//End var body: some View
  
  
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
