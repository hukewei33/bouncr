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
  
    var body: some View {
      
      NavigationView {
        
        ScrollView((scroll ? .horizontal : .vertical), showsIndicators: false) {
          
          // old invitations stack
          // this has a better look to it (fixes some of the weirdness from the animation
          // but because it turns into a zstack not a hstack, it doesn't let horizontal scrolling work as well
          
//          ZStack {
//
//            ForEach(0..<viewModel.allEvents.count, id: \.self) { index in
//
//                InviteCard(event: viewModel.allEvents[index])
//                  .offset(x: (move ? CGFloat(((center - index)*300) + 40) : 0), y: (move ? 0 : CGFloat(index*80)))
//                  .onTapGesture {
//                    print(index)
//                    self.center = index
////                    self.move.toggle()
//                    move = true
//                    scroll = true
//                  }
//
//
//            }.animation(.spring())
          
//        }.padding(.top, 50)
          
          
          if (!move){
            
            ZStack {
            
              ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in
                
                InviteCard(event: viewModel.indexGuestEvents()[index])
                  .offset(y: CGFloat(index*80))
                  .onTapGesture {
                    self.move.toggle()
                    self.scroll.toggle()
                    self.center = index
                  }
              
              }
            
            
            }.animation(.spring())
            .padding(.top, 50)
          
          }
          else {
            
              
              HStack {
              
                ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in
                  
                  InviteCard(event: viewModel.indexGuestEvents()[index])
                    .onTapGesture {
                      self.move.toggle()
                      self.scroll.toggle()
                    }
                  
                  // for V2 add code so that it automatically scrolls to the right card clicked
                
                }
              
              
              }.animation(.spring())
              .padding([.trailing, .leading], 40)
              
            
          }
          
        }.animation(.spring())
      
        
        .navigationBarTitle("Invitations")
      }.edgesIgnoringSafeArea([.top])
      
    }
      
}
