//
//  FriendRequest.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/6/22.
//

import SwiftUI

struct FriendRequest: View {
    @EnvironmentObject var mainController: MainController
    @ObservedObject var otherUserController: OtherUserController
    
    init(otherUserController: OtherUserController){
        self.otherUserController=otherUserController
    }
    var body: some View {
        VStack {
            if (otherUserController.friendRequestArray.count > 0){
                List {
                    Section(header: Text("Friend Requests").padding(.top, 5)){
                        ForEach(otherUserController.friendRequestArray) { requestingUser in
                            Group {
                                Text(requestingUser.firstName) +
                                Text(" ") +
                                Text(requestingUser.lastName)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    self.otherUserController.processFriendRequest(senderID: requestingUser.id , accept: true) {
                                        otherUserController.getPendingRecievedFriends()
                                    }
                                }){
                                    HStack{
                                        Text("Accept")
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .leading) {
                                Button(action: {
                                    self.otherUserController.processFriendRequest(senderID: requestingUser.id , accept: false){
                                        otherUserController.getPendingRecievedFriends()
                                    }
                                }){
                                    HStack{
                                        Text("Decline")
                                        Image(systemName: "x.circle")
                                            .foregroundColor(.white)
                                    }
                                }
                                .tint(.red)
                            }
                        }
                    }
                }
                .padding(.top, -55)
                .listStyle(InsetGroupedListStyle())
            }
        }
        .onAppear() {
            mainController.otherUserController.getPendingRecievedFriends()
        }
    }
    
}
