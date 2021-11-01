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
          
          // invitations stack
          ZStack {
              
            ForEach(0..<viewModel.allEvents.count, id: \.self) { index in
                
                InviteCard(event: viewModel.allEvents[index])
                  .offset(x: (move ? CGFloat(((center - index)*300) + 40) : 0), y: (move ? 0 : CGFloat(index*80)))
                  .onTapGesture {
                    print(index)
                    self.center = index
                    self.move.toggle()
                    self.scroll.toggle()
                  }
                
              
            }.animation(.spring())
              
          }.padding(.top, 50)
          
        }
        
        .navigationBarTitle("Invitations")
      }.edgesIgnoringSafeArea(.top)
      
    }
      
}
