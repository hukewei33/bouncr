//
//  EditProfile.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/6/22.
//

import SwiftUI

struct EditProfile: View {
    @EnvironmentObject var mainController: MainController
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phonenumber: Int = 0
    @State private var birthday: Date = Date()
    @State private var profilePicURL: String = "" //optional, for now users can't edit this
    
    func initView() {
        if let user = mainController.thisUser {
            fName = user.firstName
            lName = user.lastName
            username = user.username
            email = user.email
            phonenumber = user.phoneNumber
            birthday = user.birthday
        }
    }
    
    
    //TODO: fields can be blank but other rules need to be enforced
     var buttonDisabled: Bool {
         return false
       //return (fName.isEmpty || lName.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty)
     }

     //Submit button is a faded color if disabled
     var buttonColor: Color {
       return buttonDisabled ? Color("Disabled Button") : Color("Primary - Indigo")
     }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                //User Name field
                Group {
                    Text("User Name")
                        .bold()
                        .font(.system(size: 17))
                    Text(
                        username
                    )
                    .padding()
                    .background(Color("Form Field Background"))
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                //First Name field
                Group {
                    Text("First Name")
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
                    Text("Last Name")
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
                
                
                //Email field
                Group {
                    Text("Email")
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
                
                //phonenumber field
                Group {
                    Text("Phonenumber")
                        .bold()
                        .font(.system(size: 17))
                    TextField(
                        "Phonenumber",
                        value: $phonenumber,
                        formatter: NumberFormatter()
                    )
                    .padding()
                    .background(Color("Form Field Background"))
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                //birthday field
                Group {
                    Text("Birthday")
                        .bold()
                        .font(.system(size: 17))
                    Text(birthday, style: .date)
                    .padding()
                    .background(Color("Form Field Background"))
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                }
                
                //Password field
                Group {
                    Text("Password")
                        .bold()
                        .font(.system(size: 17))
                    SecureField(
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
                        print("EDITING PROFILE...")
                        let newUserInfo = User(id: -1, firstName: fName, lastName: lName, email: email, username: username, phoneNumber: phonenumber, birthday: birthday, orgUser: nil, password: password == "" ? nil : password, token: nil)
                        mainController.updateUser(updatedUser: newUserInfo)
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
                    
                }
            } //End VStack
            .padding(30)
            .onAppear{ initView() }
        } //End ScrollView
        .navigationTitle("Edit Profile")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


