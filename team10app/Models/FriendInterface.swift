//
//  FriendInterface.swift
//  team10app
//
//  Created by Kenny Hu on 11/8/21.
//
import Foundation

import Firebase

class FriendInterface {
  
    var Friends: [Friend] = []
    let friendReference = Database.database().reference(withPath: "friends")
    
//    init(userKey:String){
//
//        self.fetch (userKey:userKey){friends in return }
//
//    }
    
    func create(userKey1: String, userKey2: String,originUserId:String )-> String?{
        let keyResult :String? = self.friendReference.childByAutoId().key
        if let userId = keyResult{
            let newFriend = Friend(userKey1: userKey1 ,userKey2:userKey2,
                                   key: userId,
                            originUserId:originUserId
                            )
            self.friendReference.child(userId).setValue(newFriend.toAnyObject())
            return userId
        }
        else{
            print("failed to add friend")
            return nil
        }
    }
    

    func fetch(userKey:String, completionHandler: @escaping ([Friend]) -> Void) {
            self.friendReference.queryOrdered(byChild: "userKey1").observe(.value, with: { snapshot in
            var newFriends: [Friend] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let friend = Friend(snapshot: snapshot) {
                    if friend.userKey1 == userKey{
                        newFriends.append(friend)
                        //print(host.userKey)
                    }
                }
            }
            self.Friends = newFriends
            completionHandler(self.Friends)
        })

    }
    
    func update(key:String, updateVals:[String : Any]){
        self.friendReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.friendReference.child(key).removeValue()
    }
    
}
