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
  
    var body: some View {
      
      NavigationView {
        
        ScrollView {
          
          // invitations stack
          ZStack {
              
            ForEach(0..<viewModel.allEvents.count, id: \.self) { index in
              
              InviteCard(event: viewModel.allEvents[index])
                .offset(y: CGFloat(index*80))
              
            }
              
          }
          
        }
        .padding(50)
        .navigationBarTitle("Invitations")
        
      }.edgesIgnoringSafeArea(.top)
      
    }
      
}
