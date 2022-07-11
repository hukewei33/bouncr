//
//  OtherUserServiceMock.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/10/22.
//


import Foundation
@testable import Bouncr


final class OtherUserServiceMock: Mockable, OtherUserServiceable {
    func createFriends(senderID: Int, recieverID: Int, token: String) async -> Result<GenericResponse, RequestError> {
        if (senderID == -1){
            return .success(loadJSON(filename: "BadGenericResponse", type: GenericResponse.self))
        }
        return .success(loadJSON(filename: "GoodGenericResponse", type: GenericResponse.self))
    }
    
    func accpetFriends(senderID: Int, recieverID: Int, token: String) async -> Result<GenericResponse, RequestError> {
        if (senderID == -1){
            return .success(loadJSON(filename: "BadGenericResponse", type: GenericResponse.self))
        }
        return .success(loadJSON(filename: "GoodGenericResponse", type: GenericResponse.self))
    }
    
    func deleteFriends(senderID: Int, recieverID: Int, token: String) async -> Result<GenericResponse, RequestError> {
        if (senderID == -1){
            return .success(loadJSON(filename: "BadGenericResponse", type: GenericResponse.self))
        }
        return .success(loadJSON(filename: "GoodGenericResponse", type: GenericResponse.self))
    }
    
    func getFriendRequests(id: Int, isSent: Bool, token: String) async -> Result<[OtherUser], RequestError> {
        return .success(loadJSON(filename: "ReturnOtherUserArray", type: [OtherUser].self))
    }
    
    func getEventGuests(id: Int, user_id:Int,checkedin: Bool?, inviteStatus: Bool?, isFriend: Bool?, token: String) async -> Result<[OtherUser], RequestError> {
        return .success(loadJSON(filename: "ReturnOtherUserArray", type: [OtherUser].self))
    }
    
    func getFriends(id: Int, token: String) async -> Result<[OtherUser], RequestError> {
        return .success(loadJSON(filename: "ReturnOtherUserArray", type: [OtherUser].self))
    }
    
    
    func getEventGuests(id: Int, checkedin: Bool, inviteStatus: Bool, token: String) async -> Result<[OtherUser], RequestError> {
        return .success(loadJSON(filename: "ReturnOtherUserArray", type: [OtherUser].self))
    }
    
    func getEventHosts(id: Int, token: String) async -> Result<[OtherUser], RequestError> {
        return .success(loadJSON(filename: "ReturnOtherUserArray", type: [OtherUser].self))
    }
    
    func getSearchResults(term: String, token: String) async -> Result<[OtherUser], RequestError> {
        return .success(loadJSON(filename: "ReturnOtherUserArray", type: [OtherUser].self))
    }
}
