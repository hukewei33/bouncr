//
//  Controller.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//
//this is the main controller, all other controller are encapsulated in it
import Foundation
import SwiftUI

//TODO: define interface for the girls

class MainController: ObservableObject {
    @Published var thisUser: User?
    @Published var errorMessage: String?
    @Published var loading: Bool=false
    var token: String
    let userService:UserServiceable
    let otherUserController:OtherUserController=OtherUserController()
    let hostedEventController:HostedEventController=HostedEventController()
    let inviteController:InviteController=InviteController()
    
    init(service: UserServiceable = UserService()) {
        token=""
        thisUser=nil
        errorMessage=nil
        userService=service
        setParent()
    }
    
    func login(username: String, password: String,completion: (() -> Void)? = nil){
        print("logging in")
        Task.init{
            let result = await userService.userLogin(username: username, password: password)
            switch result {
            case .success(let loginResponse):
                thisUser=loginResponse
                token = loginResponse.token!
                completion?()
            case .failure(let error):
                errorMessage=error.customMessage
                print(errorMessage)
                completion?()
            }
        }
    }
    
    func setParent(){
        otherUserController.setParent(newParent: self)
        hostedEventController.setParent(newParent: self)
        inviteController.setParent(newParent: self)
    }
    
    
    func loggedin()->Bool{return token != ""}
    
    func logout(){
        thisUser=nil
        token=""
    }
    
    //we create a user object with a password, the passed in user object must have a password field, the id field is ignored so it can be anything
    func createUser(newUser: User,  completion: (() -> Void)? = nil){
        let newUserDict:[String:String]? = newUser.toDict()
        Task.init{
            let result = await userService.createUser(newUser: newUserDict)
            switch result {
            case .success(let loginResponse):
                thisUser=loginResponse
                token = loginResponse.token!
                completion?()
            case .failure(let error):
                errorMessage=error.customMessage
                print(errorMessage)
                completion?()
            }
        }
    }
    //we pass in a new instance of user, the password and org fields are not required, any user field should be changed, the id cannot change
    func updateUser(updatedUser: User, completion: (() -> Void)? = nil){
        let updatedUserDict = updatedUser.toDict()
        Task.init{
            let result = await userService.updateUser(id: thisUser!.id, updateUser: updatedUserDict, token: token)
            switch result {
            case .success(let loginResponse):
                thisUser=loginResponse
                token = loginResponse.token!
                completion?()
            case .failure(let error):
                errorMessage=error.customMessage
                print(errorMessage)
                completion?()
            }
        }
    }
    
    func manualLoginForTesting(){
        thisUser = User(id: 4, firstName: "Kenny", lastName: "Hu", email: "kenny@andrew.cmu.edu", username: "khu", phoneNumber: 123456789, birthday: Date(), orgUser: nil, password: nil,token: nil)
        token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU"
    }
  
}
