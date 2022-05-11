//
//  Endpoint.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "http://127.0.0.1:3000/"
    }
}


