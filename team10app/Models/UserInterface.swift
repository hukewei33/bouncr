//
//  UserController.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase

class UserInterface {
  
    var Users: [User] = []
    var CurrentUser : User? = nil
    
    init(userKey:String){
        self.populate(key:userKey)
    }
    
    let usersReference = Database.database().reference(withPath: "users")
    
    func create(firstName: String, lastName : String, email: String, passwordHash: String , username: String)-> String?{
        let keyResult :String? = self.usersReference.childByAutoId().key
        if let userId = keyResult {
            let newUser = User(firstName: firstName,
                            lastName: lastName,
                            email:email,
                            username:  username,
                            profilePicURL: nil ,
                            passwordHash: passwordHash,
                            key: userId
                            )
            self.usersReference.child(userId).setValue(newUser.toAnyObject())
            return userId
        }
        else{
            print("failed to add user")
            return nil
        }
    }
    

    func populate(key:String){
        self.usersReference.queryOrdered(byChild: "firstName").observe(.value, with: { snapshot in
            var newUsers: [User] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let user = User(snapshot: snapshot) {
                    //print(user.firstName)
                    newUsers.append(user)
                    if user.key == key{
                        self.CurrentUser = user
                    }
                }
            }
            self.Users = newUsers
        })
    }
    
    
    func update(key:String, updateVals:[String : Any]){
        self.usersReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.usersReference.child(key).removeValue()
    }
    
    
}
