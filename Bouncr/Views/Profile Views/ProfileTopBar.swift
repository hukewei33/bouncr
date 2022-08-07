//
//  ProfileTopBar.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/6/22.
//

import SwiftUI

struct ProfileTopBar: View {
    @EnvironmentObject var mainController: MainController
    
    var body: some View {
        HStack {
            // need to still write code for profile pic here
            // we use a default profile picture for now
            AsyncImage(
                url: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png"),
                content: { image in
                    image.resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(50)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            VStack(alignment: .leading) {
                
                // display username
                Text("@" + mainController.thisUser!.username)
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                
                // display name
                Text(mainController.thisUser!.firstName + " " + mainController.thisUser!.lastName)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
            }
            
            .padding([.leading, .trailing], 5)
            Spacer()
            
            NavigationLink(destination: EditProfile()){
                
                ZStack {
                    Image(systemName: "square.and.pencil")
                        .font(.system(.title))
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    
                }
                .padding([.leading, .trailing], 5)
                
            }
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .padding(.top, 50)
        .padding(.bottom, 0)
        .padding([.horizontal], 30)
        .background(Color(red: 66/255, green: 0, blue: 1.0, opacity: 1.0))
        .edgesIgnoringSafeArea(.top)
    }
}


