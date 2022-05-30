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
    
    //if new target is required, change target param in call
    func setOtherUserArray(result:Result<[OtherUser], RequestError>, target: inout [OtherUser] ){
        switch result {
        case .success(let res):
            target=res
        case .failure(let error):
            print(error.customMessage)
            setErrorMessage(message: error.customMessage)
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
    
    //get all attending guests
    func getGuest(eventID:Int,checkedin: Bool, inviteStatus: Bool,isFriend: Bool, completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await otherUserService.getEventGuests(id: eventID, checkedin: checkedin, inviteStatus: inviteStatus,isFriend: isFriend,token: getToken())
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
            case .success(let res): break
                //need to define feedback
            case .failure(let error):
                print(error.customMessage)
                setErrorMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    func processFriendRequest(recieverID:Int,accept:Bool,completion: (() -> Void)? = nil){
        if accept{
            Task.init{
                let result = await otherUserService.createFriends(senderID: getUserID(), recieverID: recieverID, token: getToken())
                switch result {
                case .success(let res): break
                    //need to define feedback
                case .failure(let error):
                    print(error.customMessage)
                    setErrorMessage(message: error.customMessage)
                }
                completion?()
            }
        }
        else{
            deleteFriendRequest(recieverID: recieverID,completion: completion)
        }
        
    }
    
    func deleteFriendRequest(recieverID:Int,completion: (() -> Void)? = nil){
        Task.init{
            let result = await otherUserService.deleteFriends(senderID: getUserID(), recieverID: recieverID, token: getToken())
            switch result {
            case .success(let res): break
                //need to define feedback
            case .failure(let error):
                print(error.customMessage)
                setErrorMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    
    
}
