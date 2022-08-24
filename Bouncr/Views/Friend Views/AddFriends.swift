//
//  AddFriends.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/6/22.
//

import SwiftUI

struct AddFriends: View {
    @EnvironmentObject var mainController: MainController
    @ObservedObject var otherUserController: OtherUserController
    
    @State private var searchText: String = ""
    @State private var searchResults: [OtherUser] = []
    
    init(otherUserController: OtherUserController){
        self.otherUserController=otherUserController
        //resetFriends()
    }
    
    func displayResults() {
        if searchText == "" {
            searchResults = []
        } else {
            otherUserController.getSearch(term: searchText){
                searchResults = Array(Set(otherUserController.otherUserArray).subtracting(otherUserController.friendArray).subtracting(otherUserController.sentFriendRequestArray))
            }
        }
    }
    
    func resetFriends(){
        otherUserController.getFriends()
        otherUserController.getPendingSentFriends()
    }
    
    
    var body: some View {
        
        //Copied & edited from SwiftRepos lab, for searh functionality
        let binding = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            self.displayResults()
        })
        
        
        // PopUp Window
        VStack(alignment: .leading) {
            //Top Bar
            HStack {
                
                Text("Find Friends")
                    .font(.system(size: 20))
                
                Spacer()
            }//HStack Ends
            .padding(.bottom)
            
            //Search Bar
            HStack {
                Spacer()
                
                VStack {
                    
                    //Search bar
                    TextField(
                        "Search for Friends",
                        text: binding
                    )
                    .padding(.bottom, 30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
                    
                    //List of users
                    ScrollView {
                        VStack(alignment: .leading) {
                            //Can only show users if they exist in search results
                            if (searchResults.count>0) {
                                ForEach(0..<self.searchResults.count, id: \.self) { index in
                                    AddFriendRow(user: searchResults[index], otherUserController: otherUserController)
                                        .padding(10)
                                }
                            }
                            //Display appropriate message if there are no relevant search results
                            else {
                                Text("No search results")
                                    .foregroundColor(Color("Gray - 400"))
                            }
                        }
                        .padding()
                    }
                    .cornerRadius(10)
                    .frame(width: 250, height: 375)
                    .border(Color("Gray - 100"))
                    
                }
                
                Spacer()
            }
            
        }//VStack Ends
        .onAppear {
            resetFriends()
        }
    }
    
}

