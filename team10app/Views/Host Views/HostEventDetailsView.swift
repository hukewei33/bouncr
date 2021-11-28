//
//  HostEventDetailsView.swift
//  team10app
//
//  Created by GraceJoseph on 11/4/21.
//

import Foundation
import SwiftUI
import UIKit
import CodeScanner

struct HostEventDetailsView: View {
  
  @ObservedObject var viewModel = ViewModel()
  @State private var isShowingScanner = false
  @State private var showPopUp: Bool = false
  @State private var showAlert = false
  var event: Event
  var ongoing: Bool
  
  let columns = [GridItem(.fixed(100)), GridItem(.flexible())]
  let rows = [GridItem(.fixed(30))]
  let date: Date
  let dateStr: String
  let title: String
  
  init(event: Event, ongoing: Bool) {
    self.event = event
    self.ongoing = ongoing
    let timeInterval = TimeInterval(event.startTime)
    date = Date(timeIntervalSince1970: timeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, hh:mm a z"
    dateStr = dateFormatter.string(from: date)
    
    if (ongoing){
      self.title = event.name + " 🟢"
    }
    else {
      self.title = event.name
    }
  }
  
  var body: some View {
    
    ZStack {
      
      VStack {
        
        VStack (alignment: .leading) {
          
          Text(dateStr)
            .foregroundColor(.white)
            .font(.system(size: 18))
          
          HStack {

            // number of attendees currently checked in
            VStack (alignment: .center) {

              Text ("# / #") // placeholder
                .fontWeight(.bold)
                .padding(.bottom, 4)
              Text ("checked in")

            }
            .foregroundColor(.white)

            Spacer()

            // number of friends invited
            VStack (alignment: .center) {

              Text ("#") // placeholder
                .fontWeight(.bold)
                .padding(.bottom, 4)
              Text ("friends invited")

            }
            .foregroundColor(.white)
            .padding(10)

            Spacer(minLength: 30)

          }
          .padding(.top, 10)
          
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .padding(.leading, 20)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        

        VStack(alignment: .leading) {
        
          LazyVGrid(columns: columns, alignment: .leading, spacing: 25) {
            
            Text("Location: ")
              .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            
            Text("\(event.street1), \n\(event.city), \(event.state), \(event.zip)")
            
            if !(event.description ?? "").isEmpty {
                
              Text("About: ")
                .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
              
              Text(event.description!)
              
            }
            
            Text("Guest List: ")
              .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            
            LazyHGrid(rows: rows, alignment: .lastTextBaseline) {
              
              VStack {

                 //Below is code for the actual button
                 Button(action: {
                   withAnimation(.linear(duration: 0.3)) {showPopUp.toggle()}
                 }, label: {
                   Image(systemName: "plus")
                     .foregroundColor(Color.white)
                     .frame(width: 30, height: 30)
                 })
                 .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
                 .cornerRadius(38.5)
                 .padding()
                 .shadow(color: Color.black.opacity(0.3),
                         radius: 3,
                         x: 3,
                         y: 3)

                 Text("Add Guests")
                   .font(.system(size: 10))

               }
               .frame(width: 60, height: 30, alignment: .center)

               // for each guest invited should show a small circle with the first name under it
               // for v2 make it just the first 6 guests
               ForEach(0..<viewModel.indexEventGuests(eventKey: event.key).count, id: \.self){ index in

                 VStack {

                   ZStack {
                     Circle()
                       .fill(Color("Primary - Indigo"))
                   }

                   Text(viewModel.indexEventGuests(eventKey: event.key)[index].firstName)
                     .font(.system(size: 10))
                 }
               }
            
            }
            .padding(.top, 30)

          }
          .padding(40)
          
          VStack {
            
            HStack (alignment: .center){
              
              
              Spacer()
              
              NavigationLink(destination: EditEventView(viewModel: self.viewModel, event: self.event)){
                Text("Edit")
                  .frame(width: 100, height: 30)
                  .background(Color.white)
                  .cornerRadius(10)
                  .overlay(
                      RoundedRectangle(cornerRadius: 10)
                          .stroke(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)), lineWidth: 1)
                  )
                  .padding(.bottom)
              }
              
              //New delete button, shows alert for confirmation before deleting an event
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
                        self.viewModel.cascadeEventDelete(eventKey: event.key)
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
                CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
              }
            }
          }

          Spacer()

          .navigationBarTitle(title)
        }
        .navigationViewStyle(StackNavigationViewStyle())
      }//end vstack
        
      InviteGuestsModal(show: $showPopUp, viewModel: self.viewModel, event: self.event)
    }//end zstack
  }
  
  
  func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    self.isShowingScanner = false
     
    switch result {
    case .success(let code):
      let details = code.components(separatedBy: "\n")
      print(details)
      guard details.count == 2 else { return }

      print("success" + code)
    case .failure(let error):
      print("failure")
    }
  }
  
}
