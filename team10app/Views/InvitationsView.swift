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
          
          
          if (!move){
            
            ZStack {
            
              ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in
                InviteCard(event: viewModel.indexGuestEvents()[index])
                  .offset(y: CGFloat(index*100))
                  .onTapGesture {
                    self.move.toggle()
                    self.scroll.toggle()
                    self.center = index
                  }
              }
              
            }.animation(.spring())
            .padding(.top, 40)
          
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
          
        }
        .animation(.spring())
        .navigationBarTitle("Invitations")
        
      }
      .edgesIgnoringSafeArea([.top])
      .navigationViewStyle(StackNavigationViewStyle())
      
    }
}
