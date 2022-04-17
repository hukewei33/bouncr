//
//  InvitationDetailView.swift
//  team10app
//
//  Created by GraceJoseph on 10/29/21.
//

import Foundation
import SwiftUI

struct InvitationDetailView: View {
  
  @EnvironmentObject var viewModel: ViewModel
  
  var position: CGFloat
  
  init(position: CGFloat){
    self.position = position
  }
  
  var body: some View {
  
      
      ScrollView(.horizontal, showsIndicators: false) {
        
        // invitations stack
        HStack {
            
          ForEach(0..<viewModel.indexGuestEvents().count, id: \.self) { index in
            
           
            InviteCard(event: viewModel.indexGuestEvents()[index])
                .offset(y: position)
              
            
          }
            
        }
        
      }
      
      
    }
  
}
