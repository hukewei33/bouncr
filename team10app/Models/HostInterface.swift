//
//  HostInterface.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase


class HostInterface {
  
    var Hosts: [Host] = []
    let hostsReference = Database.database().reference(withPath: "hosts")
    
//    init(userKey:String){
//
//        self.fetch (userKey:userKey){hosts in return }
//
//    }
    
    func create(userKey: String, eventKey: String)-> String?{
        let keyResult :String? = self.hostsReference.childByAutoId().key
        if let userId = keyResult{
            let newHost = Host(userKey: userKey ,
                            eventKey:eventKey,
                            key : userId)
            self.hostsReference.child(userId).setValue(newHost.toAnyObject())
            return userId
        }
        else{
            print("failed to add host")
            return nil
        }
    }
    

    func fetch(userKey:String, completionHandler: @escaping ([Host]) -> Void) {
            self.hostsReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
            var newHosts: [Host] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let host = Host(snapshot: snapshot) {
                    if host.userKey == userKey{
                        newHosts.append(host)
                        //print(host.userKey)
                    }
                }
            }
            self.Hosts = newHosts
            completionHandler(self.Hosts)
        })

    }
    
    func update(key:String, updateVals:[String : Any]){
        self.hostsReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.hostsReference.child(key).removeValue()
    }
    
}

//class HostInterface {
//
//    var Hosts: [Host] = []
//    let hostsReference = Database.database().reference(withPath: "hosts")
//
//    init(userKey:String){
//
//        self.fetch (userKey:userKey){hosts in return }
//
//    }
//
//    func create(userKey: String, eventKey: String)-> String?{
//        let keyResult :String? = self.hostsReference.childByAutoId().key
//        if let userId = keyResult{
//            let newHost = Host(userKey: userKey ,
//                            eventKey:eventKey,
//                            key : userId)
//            self.hostsReference.child(userId).setValue(newHost.toAnyObject())
//            return userId
//        }
//        else{
//            print("failed to add host")
//            return nil
//        }
//    }
//
//
//    func fetch(userKey:String, completionHandler: @escaping ([Host]) -> Void) {
//            self.hostsReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
//            var newHosts: [Host] = []
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                   let host = Host(snapshot: snapshot) {
//                    if host.userKey == userKey{
//                        newHosts.append(host)
//                        //print(host.userKey)
//                    }
//                }
//            }
//            self.Hosts = newHosts
//            completionHandler(self.Hosts)
//        })
//
//    }
//
//    func update(key:String, updateVals:[String : Any]){
//        self.hostsReference.child(key).updateChildValues(updateVals)
//    }
//
//    func delete(key:String ){
//        self.hostsReference.child(key).removeValue()
//    }
//
//}
