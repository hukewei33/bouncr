//
//  GenericResponse.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/29/22.
//

import Foundation
struct GenericResponse: Codable {
    let returnValue:Int
    let returnString:String?
    func getErrorEnum() -> RequestError? {
        if returnValue>0{
            return nil
        }
        switch returnValue{
        case -2: return .invalidLogin
        case -5: return .unauthorized
        default:return .serverSideError
        }
    }
}
