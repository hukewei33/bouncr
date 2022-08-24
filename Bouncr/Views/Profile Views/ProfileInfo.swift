//
//  ProfileInfo.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/11/22.
//

import SwiftUI

struct ProfileInfo: View {
    @EnvironmentObject var mainController: MainController
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                //User Name field
                Group {
                    Text("User Name")
                        .bold()
                        .font(.system(size: 17))
                    Text(
                        mainController.thisUser!.username
                    )
                    .padding()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                //First Name field
                Group {
                    Text("First Name")
                        .bold()
                        .font(.system(size: 17))
                    Text(
                        mainController.thisUser!.firstName
                    )
                    .padding()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                //Last Name field
                Group {
                    Text("Last Name")
                        .bold()
                        .font(.system(size: 17))
                    Text(
                        mainController.thisUser!.lastName
                    )
                    .padding()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                
                //Email field
                Group {
                    Text("Email")
                        .bold()
                        .font(.system(size: 17))
                    Text(
                        mainController.thisUser!.email
                    )
                    .padding()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                //phonenumber field
                Group {
                    Text("Phonenumber")
                        .bold()
                        .font(.system(size: 17))
                    Text(
                        "\(mainController.thisUser!.phoneNumber)" )
                    .padding()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                //birthday field
                Group {
                    Text("Birthday")
                        .bold()
                        .font(.system(size: 17))
                    Text(mainController.thisUser!.birthday, style: .date)
                    .padding()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                Spacer()
                
            } //End VStack
        }
        
    }
}


