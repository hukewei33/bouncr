//
//  InviteController.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
import SwiftUI


class InviteController: HelperController,ObservableObject {

    
    let inviteService:InviteServiceable 
    
    init(service:InviteServiceable = InviteService()){
        inviteService=service
    }
    
    @Published var InviteArray:[Invite]=[]
    @Published var InviteShowed:Invite?=nil
    
  
    
    func getInvites(completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await inviteService.getInvites(id: getUserID(), token: getToken())
            setLoading(status:false)
            switch result {
            case .success(let Invites):
                InviteArray=Invites
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    //the id is ignored and can be anything
    func createInvite(newInvite:Invite,completion: (() -> Void)? = nil){
        let newInviteDict = newInvite.toDict()
        Task.init{
            setLoading(status: true)
            let result = await inviteService.createInvite(newInvite: newInviteDict, token: getToken())
            setLoading(status:false)
            switch result {
            case .success(let Invite):
                InviteShowed=Invite
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    func updateInvite(updatedInvite:Invite,completion: (() -> Void)? = nil){
        let updatedInviteDict = updatedInvite.toDict()
        Task.init{
            setLoading(status: true)
            let result = await inviteService.updateInvite(id: updatedInvite.id, newInvite: updatedInviteDict, token: getToken())
            setLoading(status:false)
            switch result {
            case .success(let Invite):
                InviteShowed=Invite
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    func deleteInvite(deletedInviteID:Int,completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await inviteService.deleteInvite(id: deletedInviteID, token: getToken())
            setLoading(status:false)
            //TODO: change return type
            switch result {
            case .success(let res):
                if let message = res.returnString{
                    setStatusMessage(message: message)
                }
                if(res.returnValue != 0){
                  //what to do in fail?
                }
            case .failure(let error):
                print(error.customMessage)
            }
            completion?()
        }
    }
    
    
}
