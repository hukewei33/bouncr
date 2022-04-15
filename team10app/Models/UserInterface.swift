//
//  UserController.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation


struct dataWrapper: Decodable{
    let user: UserAttributes
    let id:String
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case user = "attributes"
    }
    
}

struct IndexResult: Decodable {
  let wrappers: [dataWrapper]

  enum CodingKeys : String, CodingKey {
    case wrappers = "data"
  }
}

struct GetResult: Decodable {
  let wrappers: dataWrapper

  enum CodingKeys : String, CodingKey {
    case wrappers = "data"
  }
}



class UserInterface {
    
    func indexUsers(url: String, token: String, network: Network) async throws-> [User] {
        do{
            let data = try await network.getAPICaller(urlString: url,token: token)
            guard let result = try? JSONDecoder().decode(IndexResult.self, from: data!) else {
                print("Error: Couldn't decode data into a result")
                return []
            }
            return result.wrappers.map{$0.user.makeUser(key: $0.id)}
        }
        catch{
            return []
        }
    }
    

    func showUser(url: String, token: String, network: Network) async throws -> User? {
        do{
            let data = try await network.getAPICaller(urlString: url,token: token)
            guard let result = try? JSONDecoder().decode(GetResult.self, from: data!) else {
                print("Error: Couldn't decode data into a result")
                return nil
            }
            return result.wrappers.user.makeUser(key: result.wrappers.id)
        }
        catch{
            print("api failed")
            return nil
        }
    }
        
}
