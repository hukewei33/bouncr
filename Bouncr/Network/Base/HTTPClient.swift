//
//  HTTPClient.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,responseModel: T.Type) async -> Result<T, RequestError> {
        //print(endpoint.path)
        //print(endpoint.baseURL + endpoint.path)
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                print("i got no response?")
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                    guard let decodedGenericResponse = try? decoder.decode(GenericResponse.self, from: data)else {
                        return .failure(.decode)
                    }
                    return .failure(.serverSideError)
                }
                return .success(decodedResponse)
            
            
        case 401:
            return .failure(.unauthorized)
        case 400:
            return.failure(.serverSideError)
        default:
            print("i got unexpected code?")
            return .failure(.unexpectedStatusCode)
        }
    } catch {
        print("i was here?")
        return .failure(.unknown)
    }
}
}
