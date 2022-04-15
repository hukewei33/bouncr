//
//  Network.swift
//  team10app
//
//  Created by Kenny Hu on 4/14/22.
//

import Foundation

struct Network {
    var session = URLSession.shared

//        func loadItems(from url: URL) async throws -> LoginDecode {
//            let (data, _) = try await session.data(from: url)
//            return try JSONDecoder().decode(LoginDecode.self, from: data)
//        }
    
    func getAPICaller(urlString: String,token: String?) async throws-> Data?{
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            if let tokenVal = token{
                request.setValue(tokenVal , forHTTPHeaderField: "Authorization")
            }
             
            let (data, _) = try await session.data(from: url)
            return data
        }
        return nil
    }
}


//
//class Network {
//    var urlSession = URLSession.shared
//
//    func loginAPICaller(userName: String,password:String, completion:  @escaping (LoginDecode) ->()){
//        let task = urlSession.dataTask(with: URL(string:"http://127.0.0.1:3000/login?username="+userName+"&password="+password )!) { (data, response, error) in
//            guard let data = data else {
//              print("Error: No data to decode")
//                completion(LoginDecode())
//              return
//            }
//            guard let result = try? JSONDecoder().decode(LoginDecode.self, from: data) else {
//                print("Error: Couldn't decode data into a result")
//                completion(LoginDecode())
//                return
//            }
//            completion(result)
//        }
//        task.resume()
//    }
//
//    func getAPICaller(urlString: String,token: String, completion:  @escaping (Data) ->()){
//        if let url = URL(string: urlString) {
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.setValue(token , forHTTPHeaderField: "Authorization")
//            let task = URLSession.shared.dataTask(with: request) {
//                data, response, error in
//                if let data=data,  error == nil {
//                    completion(data)
//                } else {
//                    print("error=\(error!.localizedDescription)")
//                }
//            }
//            task.resume()
//        }
//    }
//
//
//
//
//
//    // the completion closure signature is (String) -> ()
//    func forData(urlString: String, completion:  @escaping (Data) -> ()) {
//        if let url = URL(string: urlString) {
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            let postString : String = "uid=59"
//            request.httpBody = postString.data(using: String.Encoding.utf8)
//            let task = URLSession.shared.dataTask(with: request) {
//                data, response, error in
//                if let data=data,  error == nil {
//                    completion(data)
//                } else {
//                    print("error=\(error!.localizedDescription)")
//                }
//            }
//            task.resume()
//        }
//    }
//}
//
//
