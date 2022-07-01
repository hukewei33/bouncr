//
//  JSONCreatable.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/5/22.
//

import Foundation

protocol JSONCreatable{
    func toDict() -> [String:String]?
}
