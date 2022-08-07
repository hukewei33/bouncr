//
//  HelperController.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
@MainActor
class HelperController: ObservableObject {


    var parent:MainController?
    func setParent(newParent:MainController){parent=newParent}
    var loading:Bool = false
    var statusMessage = ""
    
    //if manual return val set return manual, else if the helper controller has a parent set, return id of user, else return 1 as default id (for testing purposes)
    func getUserID(manual:Int = -1)->Int{
        if manual != -1 {
            return manual
        }
        if let parent = parent {
            if let user = parent.thisUser{
                return user.id
            }
            return 1
        }
        return 1
    }
    
    //if manual return val set return manual, else if the helper controller has a parent set, return security token, else return a valid token for local service
    func getToken(manual:String = "")->String{
        if manual != ""{
            return manual
        }
        if let parent = parent {
            return parent.token
        }
        return "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU"
    }
    
    func setLoading(status:Bool){
        self.loading=status
    }
    
    func setStatusMessage(message:String){
        self.statusMessage=message
    }
    
    
}
