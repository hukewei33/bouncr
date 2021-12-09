////
////  InvitationsHorizontalView.swift
////  team10app
////
////  Created by GraceJoseph on 11/28/21.
////
//
//import Foundation
//import Foundation
//import SwiftUI
//
//struct InvitationsHorizontalView: View {
//
//  @ObservedObject var viewModel = ViewModel()
//
//  var cardIndex: Int
//
//
//  // controller responsible for generating the qr code
//  var qrViewController = QRViewController()
//  
////  init(cardIndex: cardIndex){
////    self.cardIndex = cardIndex
////    print(self.cardIndex)
////  }
//
//  let date: Date
//  let dateStr: String
//
//  init(cardIndex: Int) {
//    self.cardIndex = cardIndex
//    let timeInterval = TimeInterval(event.startTime)
//    date = Date(timeIntervalSince1970: timeInterval)
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MMM. d, hh:mm a"
//    dateStr = dateFormatter.string(from: date)
//  }
//
//  var body: some View {
//
//    VStack {
//
//      ForEach(0..<cardIndex, id: \.self) { index in
//
//        VStack(alignment: .leading) {
//
//          NavigationLink(destination: InvitationsHorizontalView(cardIndex: cardIndex)){
//
//            VStack(alignment: .leading){
//
//              HStack(alignment: .top) {
//
//                Text(dateStr)
//                  .font(.system(size: 16))
//                  .foregroundColor(.gray)
//
//                  //Text("@host")
//
//        //        Text("@" + viewModel.indexEventHosts(eventKey: event.key)[0].username)
//        //          .font(.system(size: 14))
//        //          .foregroundColor(.gray)
//
//              }
//              .padding(.top, 5)
//
//              // event name
//              Text(viewModel.indexGuestEvents()[index].name)
//                .font(.system(size: 28))
//                .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
//
//              // address
//              Text(viewModel.indexGuestEvents()[index].street1)
//                .font(.system(size: 18))
//                .padding(.bottom, 10)
//                .foregroundColor(.black)
//
//            }
//
//          }
//
//
//            // description
//            if (viewModel.indexGuestEvents()[index].description != nil){
//
//              Text((viewModel.indexGuestEvents()[index].description)!)
//                .lineLimit(2)
//                .font(.system(size: 14))
//                .padding(.bottom, 10)
//                .frame(width: 200, height: 40)
//
//            }
//
//            Spacer()
//
//
//
//          // link to event
//          NavigationLink(destination: EventDetailsView(event: viewModel.indexGuestEvents()[index])){
//            Text("See Event Details")
//              .underline()
//          }
//
//          // qr code (i assumed the user id to be 1)
//          Image(uiImage: qrViewController.generateQRCode(from: "\(viewModel.indexGuestEvents()[index].key)\n1"))
//              .interpolation(.none)
//              .resizable()
//              .scaledToFit()
//            .frame(width: 250, height: 250, alignment: .center)
//
//
//        }
//        .padding()
//        .accentColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
//        .background(Color.white)
//        .frame(height: 450, alignment: .leading)
//        .cornerRadius(16)
//        .overlay(
//                RoundedRectangle(cornerRadius: 16)
//                    .stroke(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0), lineWidth: 1)
//
//
//        )
//        .clipped()
//        .shadow(radius: 5)
//        .padding()
//
//
//      }
//
//      Text("index" + String(cardIndex))
//
////      InviteCard(viewModel.indexGuestEvents()[index]: viewModel.indexGuestEvents()[cardIndex], cardIndex: cardIndex)
//
//    }.animation(.spring())
//    .padding([.trailing, .leading], 40)
//    .padding(.top, 0)
//
//  }
//}
