//
//  OrgUser.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/3/22.
//

import Foundation

struct OrgUser: Codable {
    let id:Int
    let organization:Organization
    let isAdmin:Bool
}
