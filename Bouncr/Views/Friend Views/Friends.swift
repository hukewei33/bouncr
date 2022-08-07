//
//  Friends.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/6/22.
//

import SwiftUI

struct Friends: View {
    @EnvironmentObject var mainController: MainController
    @ObservedObject var otherUserController: OtherUserController
    
    init(otherUserController: OtherUserController){
        self.otherUserController=otherUserController
    }
    var body: some View {
        
        
        VStack {
            if (otherUserController.friendArray.count > 0){
                List{
                    Section(header: Text("Friends").padding(.top, 5)){
                        ForEach(otherUserController.friendArray) { friend in
                            Group {
                                Text(friend.firstName) +
                                Text(" ") +
                                Text(friend.lastName)
                            }
                        }
                    }
                }
                
                
            }
            
            //                        NavigationLink(destination: AddFriends()) {
            //                          Text("Make Friend Request")
            //                            .foregroundColor(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
            //                        }
            //          //              .listRowInsets(EdgeInsets())
            //                        .navigationBarTitleDisplayMode(.inline)
            //                        .navigationBarHidden(true)
            
        }
        .padding(.top, -55)
        .listStyle(InsetGroupedListStyle())
        .onAppear() {
            mainController.otherUserController.getFriends()
        }
        
    }
}


