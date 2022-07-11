//
//  OtherUserController.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
import SwiftUI

class OtherUserController: HelperController,ObservableObject {
    
    let otherUserService:OtherUserServiceable
    
    init(service:OtherUserServiceable = OtherUserService()){
        otherUserService=service
    }
    
    //add as required
    @Published var otherUserArray:[OtherUser]=[]
    @Published var acceptedInvitesOtherUserArray:[OtherUser]=[]
    @Published var pendingInvitesOtherUserArray:[OtherUser]=[]
    @Published var allGuestsOtherUserArray:[OtherUser]=[]

    
    
    //if new target is required, change target param in call
    func setOtherUserArray(result:Result<[OtherUser], RequestError>, target: inout [OtherUser] ){
        switch result {
        case .success(let res):
            target.removeAll()
            target.append(contentsOf: res)
            //target=res
        case .failure(let error):
            print(error.customMessage)
            setStatusMessage(message: error.customMessage)
        }
    }

    //get all friends
    func getFriends(completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getFriends(id: getUserID(), token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &otherUserArray)
            completion?()
        }
    }
    
    //get all pending friends sent
    func getPendingSentFriends(completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getFriendRequests(id: getUserID(),isSent: true, token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &otherUserArray)
            completion?()
        }
    }
    
    //get all pending friends recieved
    func getPendingRecievedFriends(completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getFriendRequests(id: getUserID(),isSent: false, token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &otherUserArray)
            completion?()
        }
    }
    
    //get all user search result
    func getSearch(term:String,completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getSearchResults(term: term, token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &otherUserArray)
            completion?()
        }
    }
    
    //generic guest indexing func that populates otherUserArray
    func getGuests(eventID:Int,checkedin: Bool, inviteStatus: Bool,isFriend: Bool, completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getEventGuests(id: eventID, user_id: getUserID(), checkedin: checkedin, inviteStatus: inviteStatus,isFriend: isFriend,token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &otherUserArray)
            completion?()
        }
    }
    
    //get all guests invited to an event who has not accepted the invite
    func getPendingInviteGuests(eventID:Int, completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getEventGuests(id: eventID, user_id: getUserID(), checkedin: nil, inviteStatus: false,isFriend: nil,token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &pendingInvitesOtherUserArray)
            completion?()
        }
    }
    //get all guests invited to an event who has accepted the invite
    func getAcceptedInvitesGuests(eventID:Int,completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getEventGuests(id: eventID, user_id: getUserID(), checkedin: nil, inviteStatus: true,isFriend: nil,token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &acceptedInvitesOtherUserArray)
            completion?()
        }
    }
    //get all guests invited to an event
    func getAllGuests(eventID:Int, completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getEventGuests(id: eventID, user_id: getUserID(), checkedin: nil, inviteStatus: nil,isFriend: nil,token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &allGuestsOtherUserArray)
            completion?()
        }
    }
    
    //get all attending hosts
    func getHosts(eventID:Int, completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getEventHosts(id: eventID, token: getToken())
            setLoading(status: false)
            setOtherUserArray(result: result, target: &otherUserArray)
            completion?()
        }
    }
    
    //TODO: create end points for creating and modifying freind relationships
    
    func sendFriendRequest(recieverID:Int,completion: (() -> Void)? = nil){
        Task.init{
            let result = await otherUserService.createFriends(senderID: getUserID(), recieverID: recieverID, token: getToken())
            switch result {
            case .success(let res):
                //need to define feedback
                statusMessage = res.returnString!
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    func processFriendRequest(senderID:Int,accept:Bool,completion: (() -> Void)? = nil){
        if accept{
            Task.init{
                let result = await otherUserService.accpetFriends(senderID: senderID, recieverID: getUserID(), token: getToken())
                switch result {
                case .success(let res):
                    statusMessage = res.returnString!
                    
                case .failure(let error):
                    print(error.customMessage)
                    setStatusMessage(message: error.customMessage)
                }
                completion?()
            }
        }
        else{
            deleteFriendRequest(senderID: senderID, recieverID: getUserID(),completion: completion)
        }
        
    }
    
    func deleteFriendRequest(senderID:Int,recieverID:Int,completion: (() -> Void)? = nil){
        Task.init{
            let result = await otherUserService.deleteFriends(senderID: senderID, recieverID: recieverID, token: getToken())
            switch result {
            case .success(let res):
                statusMessage = res.returnString!
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    
    
}
