//
//  LoginDecode.swift
//  team10app
//
//  Created by Kenny Hu on 4/14/22.
//

import Foundation
struct LoginDecode: Decodable {
  let user: User?
  let token: String
 
  
  enum CodingKeys : String, CodingKey {
    case user = "user"
    case token = "token"
  }
    init(){
        self.user=nil
        self.token=""
    }
}
