import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let url = "http://127.0.0.1:3000/login?username=testUser&password=testPassword"

struct Result: Decodable {
  let user: User
  let token: String
 
  
  enum CodingKeys : String, CodingKey {
    case user = "user"
    case token = "token"
  }
}


struct User :Decodable {
    
    let key: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
//    let profilePicURL: String?
    let passwordHash: String
    let phoneNumber: Int
    
    enum CodingKeys : String, CodingKey {
      case key = "id"
      case username = "username"
      case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
        case passwordHash = "password_digest"
        case email = "email"
        
    }
    
}



let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
    guard let data = data else {
      print("Error: No data to decode")
      return
    }


    guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
      print("Error: Couldn't decode data into a result")
      return
  }

    //print("Total Count: \(result.totalCount)")
  print("---------------------------")

  print("login result:")
print("- \(result.token)")
    print("- \(result.user.username)")




}

task.resume()
