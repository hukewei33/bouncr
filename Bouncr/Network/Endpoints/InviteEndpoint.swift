//
//  InviteEndpoint.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/5/22.
//

import Foundation
enum InviteEndpoint {
    case getInvites(id:Int,token: String)
    case createInvite(newInvite: [String:String]?,token: String)
    case updateInvite(id:Int,newInvite: [String:String]?,token: String)
    case deleteInvite(id:Int,token: String)

    
}

extension InviteEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getInvites(let id, _):
            return "guest_Invites?id=\(id)"
        case.createInvite( _,_):
            return "Invites"
        case.updateInvite(let id, _,_),.deleteInvite(let id, _):
            return "Invites/\(id)"

        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createInvite:
            return .post
        case .updateInvite:
            return .patch
        case .deleteInvite:
            return .delete
        default:
            return .get
        }
        
    }
    
    var header: [String: String]? {
        // Access Token to use in Bearer header
        //let accessToken = "Your TMDB Access Token here!!!!!!!"
        switch self {
            
        case .getInvites(_,let accessToken),.deleteInvite(_,let accessToken), .createInvite(_,let accessToken),.updateInvite(_,_,let accessToken):
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .createInvite(let newInvite, _),.updateInvite(_, let newInvite, _):
            return newInvite
        default:
            return nil
        }
    }
}
