//
//  OtherUserEndpoint.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/5/22.
//

import Foundation
enum OtherUserEndpoint {
    case getFriends(id:Int,token: String)
    case getPendingFriendRequests(id:Int,isSent:Bool,token: String)
    case getEventGuests(id:Int,checkedin: Bool,inviteStatus: Bool,isFriend:Bool,token: String)
    case getEventHosts(id:Int,token: String)
    case getSearchResults(term:String,token: String)
    
    //TODO: create end points for creating and modifying freind relationships
    
}

extension OtherUserEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getFriends(let id, _):
            return "user_friends?id=\(id)"
        case.getPendingFriendRequests(let id,let isSent , _):
            return "user_pending_recieved_friend_requests?id=\(id)&isSend=\(isSent)"
       
        case .getEventGuests(let id,let checkedin, let inviteStatus,let isFriend,_):
            return "event_guests?id=\(id)&inviteStatus=\(inviteStatus)&checkedin=\(checkedin)&isFriend=\(isFriend)"
        case.getEventHosts(let id,  _):
            return "event_hosts?id=\(id)"
        case.getSearchResults(let term,  _):
            return "users_search?term=\(term)"
        }
    
        
    }

    var method: RequestMethod {
        switch self {
        default:
            return .get
        }
    
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        //let accessToken = "Your TMDB Access Token here!!!!!!!"
        switch self {

        case .getFriends(_,let accessToken),.getPendingFriendRequests(_,_,let accessToken),.getSearchResults(_,let accessToken),.getEventHosts(_,let accessToken),.getEventGuests(_,_,_,_,let accessToken):
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}