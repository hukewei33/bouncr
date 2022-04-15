import Foundation
import PlaygroundSupport
import UIKit
//PlaygroundPage.current.needsIndefiniteExecution = true



struct User :Decodable {
    

    let key: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let phoneNumber: Int


    
    enum CodingKeys : String, CodingKey {
        case key = "id"
        case username = "username"
        case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
        case email = "email"
        
    }
    
    init(key:String, at:UserAt){
        self.key=Int(key) ?? 0
        self.username = at.username
        self.phoneNumber=at.phoneNumber
        self.firstName=at.firstName
        self.lastName=at.lastName
        self.email=at.email
    }
 
}

struct UserAt :Decodable {
    
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let phoneNumber: Int


    
    enum CodingKeys : String, CodingKey {
        case username = "username"
        case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
        case email = "email"
        
    }
 
}



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


    
struct ItemLoader {
        var session = URLSession.shared

        func loadItems(from url: URL) async throws -> LoginDecode {
            let (data, _) = try await session.data(from: url)
            return try JSONDecoder().decode(LoginDecode.self, from: data)
        }
    
    func getAPICaller(urlString: String,token: String) async throws-> Data?{
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(token , forHTTPHeaderField: "Authorization")
            let (data, _) = try await session.data(from: url)
            return data
            
//            let task = URLSession.shared.dataTask(with: request) {
//                data, response, error in
//                if let data=data,  error == nil {
//                    completion(data)
//                } else {
//                    print("error=\(error!.localizedDescription)")
//                }
//            }
//            task.resume()
        }
        return nil
    }
}

func fetchData() {
        Task.init {
            do {
                let x = try await ItemLoader().loadItems(from: URL(string: "http://127.0.0.1:3000/login?username=testUser&password=testPassword")!)
                print(x.token)
            } catch {
                // .. handle error
            }
        }
}

struct dataWrapper: Decodable{
    let user: UserAt
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


func indexUsers(url: String, token: String, itemLoader: ItemLoader) async throws-> [User] {
    do{
        let data = try await itemLoader.getAPICaller(urlString: url,token: token)
        guard let result = try? JSONDecoder().decode(IndexResult.self, from: data!) else {
            print("Error: Couldn't decode data into a result")
            return []
        }
        //return []
        return result.wrappers.map{User(key:$0.id,at:$0.user)}
    }
    catch{
        return []
    }
}
    func fetchData1() {
            Task.init {
                do {
                    let x = try await indexUsers(url:"http://127.0.0.1:3000/event_hosts?id=1",token:"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.oT7kSePnYs7eVIsRIzIi0UEC7XBclsrO3qrnXwic8Zg",itemLoader: ItemLoader())
                    print(x)
                } catch {
                    // .. handle error
                }
            }
    }
    
    



fetchData()
fetchData1()



