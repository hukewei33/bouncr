//
//  LoginView.swift
//  team10app
//
//  Created by SaraSong on 11/28/21.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject var viewModel: ViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var validLogin: Bool = true


    var buttonDisabled: Bool {
      return username.isEmpty || password.isEmpty
    }

    var buttonColor: Color {
          return buttonDisabled ? Color("Disabled Button") : Color("Primary - Indigo")
    }

    var body: some View {
      //Rectangle at the top:
      ZStack {
        Text("Bouncr")
          .foregroundColor(Color.white)
          .font(.system(size: 50))
          .bold()
      }
      .frame(maxWidth: .infinity, minHeight: 200)
      .background(
        LinearGradient(gradient: Gradient(colors: [Color("Blue - 400"), Color("Primary - Indigo")]), startPoint: .top, endPoint: .bottom)
      )

      VStack(alignment: .leading) {
        //Username field:
        Group {
          Text("Username")
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


        //Password field:
        Group {
          Text("Password")
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


        if (validLogin == false) {
          Text("Invalid login information")
            .foregroundColor(Color.red)
        }

          //Login button
          Button(action: {
                  if (viewModel.login(username: username, pword: password) ==  false) {
                    print("Invalid Login")
                    validLogin = false
                  }
                 
               },
               label: {
                  Text("Log in")
                  .bold()
                  .foregroundColor(Color.white)
                  .font(.system(size: 15))
                  .padding(10)
               }
        )
          .frame(maxWidth: .infinity, minHeight: 50)
          .background(buttonColor)
          .cornerRadius(10)
          .disabled(buttonDisabled)
      }
      .padding(30)

      Spacer()

    }
}
