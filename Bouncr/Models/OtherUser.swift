//
//  OtherUsers.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/3/22.
//

import Foundation

struct OtherUser: Codable, Identifiable, Hashable {
    let id: Int
    let username: String
    let lastName:String
    let firstName:String
    
}
