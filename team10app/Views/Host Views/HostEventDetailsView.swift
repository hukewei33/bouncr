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
  
  @EnvironmentObject var viewModel: ViewModel
  @State private var isShowingScanner = false
  @State private var showPopUp: Bool = false
  @State private var showAlert = false
  var event: Event
  var ongoing: Bool
  
  let columns = [GridItem(.fixed(100)), GridItem(.flexible())]
  let rows = [GridItem(.fixed(30))]
  let startDate: Date
  let startDateStr: String
  let endDate: Date
  let endDateStr: String
  
  init(event: Event, ongoing: Bool) {
    self.event = event
    self.ongoing = ongoing
    let startTimeInterval = TimeInterval(event.startTime)
    startDate = Date(timeIntervalSince1970: startTimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM. d, h:mm a z"
    startDateStr = dateFormatter.string(from: startDate)
    let endTimeInterval = TimeInterval(event.endTime)
    endDate = Date(timeIntervalSince1970: endTimeInterval)
    endDateStr = dateFormatter.string(from: endDate)
    
  }
  
  var body: some View {
    
    let attendance = self.viewModel.getEventAttendence(eventKey: event.key)
    
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
            else {
              Spacer()
            }
            
          }.padding(.leading, 10)
          
          Text(startDateStr)
            .foregroundColor(.white)
            .font(.system(size: 18))
            .padding(.leading, 10)
          
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


            }
            .padding([.vertical], 10)
            .padding(.leading, 20)
            
            
          }
          
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        

        VStack(alignment: .leading) {
        
          LazyVGrid(columns: columns, alignment: .leading, spacing: 25) {
            
            Text("Location: ")
              .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            
            Text("\(event.street1), \n\(event.city), \(event.state), \(event.zip)")
            
            Text("Date/Time: ")
              .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            
            Text(startDateStr) + Text(" to ") + Text(endDateStr)
            
            if !(event.description ?? "").isEmpty {
                
              Text("About: ")
                .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
              
              Text(event.description!)
              
            }
            

            Text("Pending Guests: ")
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
                 .shadow(color: Color.black.opacity(0.3),
                         radius: 3,
                         x: 3,
                         y: 3)

                 Text("Add Guests")
                   .multilineTextAlignment(.center)
                   .font(.system(size: 10))
                   .frame(height: 25)
                   

               }
               .padding(.top, 20)
               .frame(width: 50, height: 55, alignment: .center)
              
              // add see more button
              if (viewModel.indexPendingEventGuests(eventKey: event.key).count > 3){
                
                // for the first two invited
                ForEach(0..<2, id: \.self){ index in

                  VStack {
                    
                    if (viewModel.indexPendingEventGuests(eventKey: event.key)[index].profilePicURL == nil || viewModel.indexPendingEventGuests(eventKey: event.key)[index].profilePicURL == ""){

                      Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)

                    }
                    // display the non-nil profile pic
                    else {
                      Image(uiImage: viewModel.indexPendingEventGuests(eventKey: event.key)[index].profilePicURL!.load())
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                    }

                    Text(viewModel.indexPendingEventGuests(eventKey: event.key)[index].firstName)
                      .font(.system(size: 10))
                    
                  }.frame(width: 50)
                }
                
                // see more button!
                VStack {
                  //Below is code for the actual button
                  NavigationLink(destination: GuestList(event: event, guestHost: "host")){
                    Image(systemName: "ellipsis")
                       .foregroundColor(Color.white)
                       .frame(width: 30, height: 30)
                  }
                   .background(Color(.gray))
                   .cornerRadius(38.5)
                   .shadow(color: Color.black.opacity(0.3),
                           radius: 3,
                           x: 3,
                           y: 3)

                   Text("See More")
                     .multilineTextAlignment(.center)
                     .font(.system(size: 10))
                 }
                 .frame(width: 50, height: 50, alignment: .center)
              }
              
              // show just the initial guest list
              else {

                // for each guest invited should show a small circle with the first name under it
                ForEach(0..<viewModel.indexPendingEventGuests(eventKey: event.key).count, id: \.self){ index in

                  VStack {
                    
                    if (viewModel.indexPendingEventGuests(eventKey: event.key)[index].profilePicURL == nil || viewModel.indexPendingEventGuests(eventKey: event.key)[index].profilePicURL == ""){

                      Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)

                    }
                    // display the non-nil profile pic
                    else {
                      Image(uiImage: viewModel.indexPendingEventGuests(eventKey: event.key)[index].profilePicURL!.load())
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                    }

                    Text(viewModel.indexPendingEventGuests(eventKey: event.key)[index].firstName)
                      .font(.system(size: 10))
                    
                  }.frame(width: 50)
                }
              }
            }
            .padding(.top, 5)
            
            if (viewModel.indexEventGuests(eventKey: event.key).count > 0){
              
              Text("Accepted Guests: ")
                .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
              
              LazyHGrid(rows: rows, alignment: .lastTextBaseline) {
                
                // add see more button
                if (viewModel.indexEventGuests(eventKey: event.key).count > 4){
                  
                  // for each guest invited should show a small circle with the first name under it
                  ForEach(0..<3, id: \.self){ index in

                    VStack {
                      
                      if (viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == nil || viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == ""){

                        Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
                          .resizable()
                          .frame(width: 30, height: 30)
                          .aspectRatio(contentMode: .fit)
                          .cornerRadius(15)

                      }
                      // display the non-nil profile pic
                      else {
                        
                        Image(uiImage: viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL!.load())
                          .resizable()
                          .frame(width: 30, height: 30)
                          .aspectRatio(contentMode: .fit)
                          .cornerRadius(15)
                      }

                      Text(viewModel.indexEventGuests(eventKey: event.key)[index].firstName)
                        .font(.system(size: 10))
                      
                    }.frame(width: 50)
                  }
                  
                  // see more button!
                  VStack {
                    
                    NavigationLink(destination: GuestList(event: event, guestHost: "host")){
                      Image(systemName: "ellipsis")
                         .foregroundColor(Color.white)
                         .frame(width: 30, height: 30)
                    }
                      .background(Color(.gray))
                     .cornerRadius(38.5)
                     .shadow(color: Color.black.opacity(0.3),
                             radius: 3,
                             x: 3,
                             y: 3)

                     Text("See More")
                       .font(.system(size: 10))

                   }
                  .padding(.top, 2.5)
                   .frame(width: 50, height: 50, alignment: .center)

                }
                // show all 4 guests
                else {
                  
                  // for each guest invited should show a small circle with the first name under it
                  ForEach(0..<viewModel.indexEventGuests(eventKey: event.key).count, id: \.self){ index in

                    VStack {
                      if (viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == nil || viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL == ""){

                        Image(uiImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png".load())
                          .resizable()
                          .frame(width: 30, height: 30)
                          .aspectRatio(contentMode: .fit)
                          .cornerRadius(15)

                      }
                      // display the non-nil profile pic
                      else {
                        Image(uiImage: viewModel.indexEventGuests(eventKey: event.key)[index].profilePicURL!.load())
                          .resizable()
                          .frame(width: 30, height: 30)
                          .aspectRatio(contentMode: .fit)
                          .cornerRadius(15)
                      }

                      Text(viewModel.indexEventGuests(eventKey: event.key)[index].firstName)
                        .font(.system(size: 10))
                      
                    }.frame(width: 50)
                  }
                }
              }
              .padding(.top, 5)
              
            }
          }
          .padding([.leading, .trailing, .bottom], 30)
          .padding(.top, 10)
          
          VStack {
            
            HStack (alignment: .center){
              
              
              Spacer()
              
//              NavigationLink(destination: EditEventView(viewModel: self.viewModel, event: self.event)){
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
            .navigationBarTitleDisplayMode(.inline)

        }
        .navigationViewStyle(StackNavigationViewStyle())
      }//end vstack
        
      InviteGuestsModal(show: $showPopUp, event: self.event)
    }//end zstack
  }
  
  
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
  
}
