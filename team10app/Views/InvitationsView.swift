//
//  InvitationsView.swift
//  team10app
//
//  Created by Grace Joseph on 10/29/21.
//

import Foundation
import SwiftUI

struct InvitationsView: View {
  
  @ObservedObject var viewModel = ViewModel()
  @State var move = false
  @State var scroll = false
  
  @State var center = 0
  @State var cardID = 0
  @State var invitationArray = []
  
//  @State var showIncomingInvites = true
//  @State var numIncomingInvites = 0
  
  
    var body: some View {
      
      NavigationView {
        
        ScrollViewReader { scrollProxy in
          
        ScrollView(.vertical, showsIndicators: false) {
            
            if (!move){
              
              // RSVP Cards
              VStack(alignment: .leading) {
                  
                
                if (self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}.count > 0){
                  
                  Text("Incoming Invites")
                    .bold()
                    .font(.system(size: 22))
                    .padding([.trailing, .leading], 20)
                    .padding(.top, 15)
                  
                  List {
                    
                    ForEach(0..<self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}.count, id: \.self) { index in
                      if #available(iOS 15.0, *) {
                        PendingInviteCard(invite: self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}[index])
                          .swipeActions(edge: .leading) {
                            Button(action: {
                              print("declined")
                              viewModel.inviteInterface.delete(key: self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}[index].key)
                            }){
                              HStack{
                                Text("Decline")
                                Image(systemName: "x.circle")
                                  .foregroundColor(.white)
                              }
                            }
                            .tint(.red)
                          }
                          .swipeActions(edge: .trailing) {
                            Button(action: {
                              print("accepted")
                              viewModel.inviteInterface.update(key: self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}[index].key, updateVals: ["inviteStatus": true])
                            }){
                              HStack{
                                Text("Accept")
                                Image(systemName: "checkmark.circle.fill")
                                  .foregroundColor(.white)
                              }
                            }
                            .tint(.green)
                          }
                      } else {
                        // Fallback on earlier versions
                      }
                    }
                    
                  }
                  .listStyle(GroupedListStyle())
                  .frame(width: 400, height: CGFloat((self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}.count)*72), alignment: .leading)
                    .onAppear {
                        UITableView.appearance().isScrollEnabled = false
                    }
                    .onAppear(perform: {
                            UITableView.appearance().contentInset.top = -35
                        })
                  
                  Text("Current Invites")
                    .bold()
                    .font(.system(size: 22))
                    .padding([.trailing, .leading], 20)
                    .padding(.top, 15)
                    .padding(.bottom, -5)
                  
                }
                
                
              }.padding(.top, (self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}.count > 0) ? 0 : 20)
              
              VStack {

                ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in

                  InviteCard(event: viewModel.indexGuestEvents()[index])
                     .offset(y: CGFloat(-100*index))
                     .frame(height: 200)
                     .onTapGesture {
                        self.move.toggle()
                        self.scroll.toggle()
                        self.center = index
                        self.cardID = index
                        self.invitationArray = viewModel.indexGuestEvents()
//                       withAnimation {
//                         scrollProxy.scrollTo(cardID)
//                       }
                       
                      }


                }

              }.animation(.spring())
                .padding(.top, 150)
              
              // scroll view reader
              
              
//                .frame(height: CGFloat(viewModel.indexGuestEvents().count*400))
              
//              ZStack {
//
//                ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in
//
//                  NavigationLink(destination: InvitationsHorizontalView(cardIndex: index)){
//                    InviteCard(event: viewModel.indexGuestEvents()[index])
//                      .offset(y: CGFloat(index*100))
////
//                  }
//
//
//                }
//
//              }.animation(.spring())
//                .padding(.top, (self.viewModel.pendingInvites.filter{$0.userKey == "Tom"}.count > 0) ? 0 : 20)
            
            }
            else {
              
              HStack(alignment: .center) {
                
                
                Button(action: {
                  if (cardID > 0){
                    cardID -= 1
                  }
                }){
                  Image(systemName: "chevron.left")
                    .foregroundColor((cardID == 0) ? (.white) : Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
                    .font(.largeTitle)
                }
                
                
                VStack(alignment: .leading) {
                  
                  InviteCard(event: self.viewModel.indexGuestEvents()[cardID])
                  .frame(width: 300)
                  .padding(.top, 50)
                  .onTapGesture {
                    self.move.toggle()
                    self.scroll.toggle()
                  }
                 
                  
                }
                
                
                Button(action: {
                  if (cardID < self.viewModel.indexGuestEvents().count - 1){
                    cardID += 1
                  }
                }){
                  Image(systemName: "chevron.right")
                    .foregroundColor((cardID == self.viewModel.indexGuestEvents().count - 1) ? (.white) : Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
                    .font(.largeTitle)
                }
                
                
              }.padding([.leading, .trailing], 20)
                
                
              
              
              
              
//              HStack(alignment: .top) {
//
////                InviteCard(event: self.viewModel.indexGuestEvents()[cardID])
////                  .onTapGesture {
////                    self.move.toggle()
////                    self.scroll.toggle()
////                  }
////
////                ForEach(0..<cardID, id: \.self) { index in
////
////                  InviteCard(event: self.viewModel.indexGuestEvents()[index])
//////                    .offset(x: CGFloat(50*(index - cardID)))
////                    .onTapGesture {
////                      self.move.toggle()
////                      self.scroll.toggle()
////                    }
////
////
////                }
//
//                ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in
//
//                  InviteCard(event: self.viewModel.indexGuestEvents()[index])
////                    .offset(x: CGFloat(50*(index - cardID)))
//                    .id(index)
//                    .onTapGesture {
//                      self.move.toggle()
//                      self.scroll.toggle()
//                    }
//
//                }
//
//
//              }
//              .onAppear() {
//
//              }

//                HStack {
//
//                  ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in
//                    InviteCard(event: viewModel.indexGuestEvents()[index])
//                      .onTapGesture {
//                        self.move.toggle()
//                        self.scroll.toggle()
//                      }
//
//                    // for V2 add code so that it automatically scrolls to the right card clicked
//
//                  }
//                }.animation(.spring())
//                .padding([.trailing, .leading], 40)
//                .padding(.top, 0)

            }
            
          }
          .animation(.spring())
          .navigationBarTitle("Invitations")
          
        }
        
          
      }
      .edgesIgnoringSafeArea([.top])
      .navigationViewStyle(StackNavigationViewStyle())
        
    }
}
