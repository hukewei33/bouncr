//
//  InviteServiceMock.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/11/22.
//

import Foundation
@testable import Bouncr

final class InviteServiceMock: Mockable, InviteServiceable {
    func getInvites(id: Int, token: String) async -> Result<[Invite], RequestError> {
        return .success(loadJSON(filename: "ReturnInviteArray", type: [Invite].self))
    }
    
    func createInvite(newInvite: [String : String]?, token: String) async -> Result<Invite, RequestError> {
        return .success(loadJSON(filename: "ReturnInvite", type: Invite.self))
    }
    
    func updateInvite(id: Int, newInvite: [String : String]?, token: String) async -> Result<Invite, RequestError> {
        return .success(loadJSON(filename: "ReturnInvite", type: Invite.self))
    }
    
    func deleteInvite(id: Int, token: String) async -> Result<[Invite], RequestError> {
        return .success(loadJSON(filename: "ReturnInviteArray", type: [Invite].self))
    }
    
    
}
