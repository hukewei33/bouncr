//
//  Login.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation


struct Login: Codable {
    let token: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case token
        case user
       
    }
}
