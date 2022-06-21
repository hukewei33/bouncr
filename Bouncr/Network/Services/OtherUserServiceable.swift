//
//  OtherUserServiceable.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
protocol OtherUserServiceable {
    func getFriends(id:Int,token:String) async -> Result<[OtherUser], RequestError>
    func getFriendRequests(id:Int,isSent:Bool,token:String) async -> Result<[OtherUser], RequestError>
    func getEventGuests(id:Int,user_id:Int,checkedin:Bool, inviteStatus:Bool,isFriend:Bool,token:String) async -> Result<[OtherUser], RequestError>
    func getEventHosts(id:Int,token:String) async -> Result<[OtherUser], RequestError>
    func getSearchResults(term:String,token:String) async -> Result<[OtherUser], RequestError>
    //TODO: create end points for creating and modifying freind relationships
    func createFriends(senderID:Int,recieverID:Int ,token:String) async -> Result<GenericResponse, RequestError>
    func accpetFriends(senderID:Int,recieverID:Int ,token:String) async -> Result<GenericResponse, RequestError>
    func deleteFriends(senderID:Int,recieverID:Int ,token:String) async -> Result<GenericResponse, RequestError>
}

struct OtherUserService: HTTPClient, OtherUserServiceable {
    func accpetFriends(senderID: Int, recieverID: Int, token: String) async -> Result<GenericResponse, RequestError> {
        return await sendRequest(endpoint: OtherUserEndpoint.acceptFriendRequest(senderID: senderID, reccieverID: recieverID, token: token), responseModel: GenericResponse.self)
    }
    
    func deleteFriends(senderID: Int, recieverID: Int, token: String) async -> Result<GenericResponse, RequestError> {
        return await sendRequest(endpoint: OtherUserEndpoint.deleteFriendRequest(senderID: senderID, reccieverID: recieverID, token: token), responseModel: GenericResponse.self)
    }
    
    
    func createFriends(senderID:Int,recieverID:Int ,token:String) async -> Result<GenericResponse, RequestError>{
        return await sendRequest(endpoint: OtherUserEndpoint.createFriendRequest(senderID: senderID, reccieverID: recieverID, token: token), responseModel: GenericResponse.self)
    }
    
    
    func getFriendRequests(id: Int, isSent: Bool, token: String) async -> Result<[OtherUser], RequestError> {
        return await sendRequest(endpoint: OtherUserEndpoint.getPendingFriendRequests(id: id, isSent:isSent, token: token), responseModel: [OtherUser].self)
    }
        
    func getFriends(id:Int,token:String) async -> Result<[OtherUser], RequestError>{
        return await sendRequest(endpoint: OtherUserEndpoint.getFriends(id: id, token: token), responseModel: [OtherUser].self)
    }
  
    
    func getEventGuests(id:Int,user_id:Int,checkedin:Bool, inviteStatus:Bool,isFriend:Bool,token:String) async -> Result<[OtherUser], RequestError>{
        return await sendRequest(endpoint: OtherUserEndpoint.getEventGuests(user_id: user_id, id: id,checkedin: checkedin,inviteStatus: inviteStatus,isFriend:isFriend, token: token), responseModel: [OtherUser].self)
    }
    
    func getEventHosts(id:Int,token:String) async -> Result<[OtherUser], RequestError>{
        return await sendRequest(endpoint: OtherUserEndpoint.getEventHosts(id: id, token: token), responseModel: [OtherUser].self)
    }
    
    func getSearchResults(term:String,token:String) async -> Result<[OtherUser], RequestError>{
        return await sendRequest(endpoint: OtherUserEndpoint.getSearchResults(term: term, token: token), responseModel: [OtherUser].self)
    }

}
