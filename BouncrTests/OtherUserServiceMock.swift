//
//  OtherUserServiceMock.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/10/22.
//


import Foundation
@testable import Bouncr


final class OtherUserServiceMock: Mockable, OtherUserServiceable {
    func getFriendRequests(id: Int, isSent: Bool, token: String) async -> Result<[OtherUser], RequestError> {
        return .success(loadJSON(filename: "ReturnOtherUserArray", type: [OtherUser].self))
    }
    
    func getEventGuests(id: Int, checkedin: Bool, inviteStatus: Bool, isFriend: Bool, token: String) async -> Result<[OtherUser], RequestError> {
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
