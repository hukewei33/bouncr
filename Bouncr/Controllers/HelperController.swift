//
//  HelperController.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
class HelperController {


    var parent:MainController?
    func setUser(newParent:MainController){parent=newParent}
    
    //if manual return val set return manual, else if the helper controller has a parent set, return id of user, else return -1 as default id
    func getUserID(manual:Int = -1)->Int{
        if manual != -1 {
            return manual
        }
        if let parent = parent {
            if let user = parent.thisUser{
                return user.id
            }
            return -1
        }
        return -1
    }
    
    //if manual return val set return manual, else if the helper controller has a parent set, return security token, else return "" as default token
    func getToken(manual:String = "")->String{
        if manual != ""{
            return manual
        }
        if let parent = parent {
            return parent.token
        }
        return ""
    }
    
    func setLoading(status:Bool){
        if let parent = parent{
            parent.loading = status
        }
    }
    
    func setErrorMessage(message:String){
        if let parent = parent {
            parent.errorMessage=message
        }
    }
    
    
}
