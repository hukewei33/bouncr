//
//  OtherUsers.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/3/22.
//

import Foundation

struct OtherUser: Codable, Identifiable, Equatable {
    let id: Int
    let username: String
    let lastName:String
    let firstName:String
  
    static func == (lhs: OtherUser, rhs: OtherUser) -> Bool {
      return lhs.id == rhs.id
    }
    
}
