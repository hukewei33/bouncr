//
//  RequestError.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case serverSideError
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .serverSideError:
            return "Operation not allowed by service"
        default:
            return "Unknown error"
        }
    }
}
