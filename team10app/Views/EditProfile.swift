//
//  EditProfile.swift
//  team10app
//
//  Created by Sara Song on 12/2/21.
//

import SwiftUI

struct EditProfile: View {
  
  @ObservedObject var viewModel: ViewModel
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  @State private var fName: String = ""
  @State private var lName: String = ""
  @State private var username: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var profilePicURL: String = "" //optional, for now users can't edit this
  
  
  func initView() {
    if let user = viewModel.thisUser {
      fName = user.firstName
      lName = user.lastName
      username = user.username
      email = user.email
      password = user.passwordHash
      if let profPic = user.profilePicURL {
        profilePicURL = profPic //optional, for now users can't edit this
      }
    }
  }
  
  //User can't save changes if any fields are left blank
  var buttonDisabled: Bool {
    return (fName.isEmpty || lName.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty)
  }

  //Submit button is a faded color if disabled
  var buttonColor: Color {
    return buttonDisabled ? Color("Disabled Button") : Color("Primary - Indigo")
  }
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        //First Name field
        Group {
          Text("First Name *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "First Name",
            text: $fName
          )
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        }
        
        //Last Name field
        Group {
          Text("Last Name *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Last Name",
            text: $lName
          )
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        }
        
        //Username field
        Group {
          Text("Username *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Username",
            text: $username
          )
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        }
        
        //Email field
        Group {
          Text("Email *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Email",
            text: $email
          )
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        }
        
        //Password field
        Group {
          Text("Password *")
            .bold()
            .font(.system(size: 17))
          TextField(
            "Password",
            text: $password
          )
            .padding()
            .background(Color("Form Field Background"))
            .cornerRadius(10)
            .padding(.bottom, 30)
        }
        
        Spacer()
        
        //Submit button; Creates new user using viewModel
        HStack {
          Spacer()
          Button(action: {
            if let user = viewModel.thisUser {
              viewModel.userInterface.update(key: user.key,
                                              updateVals: ["firstName": fName, "lastName": lName,
                                                           "email": email, "username": username,
                                                           "profilePicURL": profilePicURL,
                                                           "passwordHash": password])
            }
            self.mode.wrappedValue.dismiss()
          }, label: {
            Text("Save changes")
              .bold()
              .foregroundColor(Color.white)
              .font(.system(size: 15))
              .padding(10)
          })
            .background(buttonColor)
            .cornerRadius(10)
            .disabled(buttonDisabled)
        }
      } //End VStack
      .padding(30)
      .onAppear{ initView() }
    } //End ScrollView
    .navigationTitle("Edit Profile")
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

