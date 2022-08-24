//
//  AddFriendRow.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/12/22.
//

import SwiftUI

struct AddFriendRow: View {
    @EnvironmentObject var mainController: MainController
    @ObservedObject var otherUserController: OtherUserController
    var user:OtherUser
    
    init(user: OtherUser, otherUserController: OtherUserController){
        self.user = user
        self.otherUserController=otherUserController
    }
    
    func sendFriendRequest(){
        otherUserController.sendFriendRequest(recieverID: user.id){
            otherUserController.getPendingSentFriends()
        }
    }
    
    var body: some View {
        HStack {
             VStack(alignment: .leading) {
               Text(user.firstName + " " + user.lastName)
               
               Text("@" + user.username)
                 .foregroundColor(Color("Gray - 400"))
                 .font(.system(size: 15))
             }//VStack End
             
             Spacer()
             
             Button(action: {
                 sendFriendRequest()
             }, label: {
               Image(systemName: "person.badge.plus")
                 .foregroundColor(Color.white)
                 .frame(width: 40, height: 40)
             })
             .background(Color(#colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)))
             .cornerRadius(10)
             .padding()
           }//Hstack End
    }
}


