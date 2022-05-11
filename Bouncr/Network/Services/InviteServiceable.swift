//
//  InviteServiceable.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
protocol InviteServiceable {
    func getInvites(id:Int,token: String)async -> Result<[Invite], RequestError>
    func createInvite(newInvite: [String:String]?,token: String)async -> Result<Invite, RequestError>
    func updateInvite(id:Int,newInvite: [String:String]?,token: String)async -> Result<Invite, RequestError>
    func  deleteInvite(id:Int,token: String)async -> Result<[Invite], RequestError>
}

struct InviteService: HTTPClient, InviteServiceable {
   
    
    func getInvites(id:Int,token: String)async -> Result<[Invite], RequestError> {
        return await sendRequest(endpoint: InviteEndpoint.getInvites(id:id,token: token), responseModel: [Invite].self)
    }
    func createInvite(newInvite: [String:String]?,token: String)async -> Result<Invite, RequestError> {
        return await sendRequest(endpoint: InviteEndpoint.createInvite( newInvite: newInvite,token: token), responseModel: Invite.self)
    }
    func updateInvite(id:Int,newInvite: [String:String]?,token: String)async -> Result<Invite, RequestError> {
        return await sendRequest(endpoint: InviteEndpoint.updateInvite(id: id, newInvite: newInvite, token: token), responseModel: Invite.self)
    }
    func  deleteInvite(id:Int,token: String)async -> Result<[Invite], RequestError> {
        return await sendRequest(endpoint: InviteEndpoint.deleteInvite(id:id,token: token), responseModel: [Invite].self)
    }
}
