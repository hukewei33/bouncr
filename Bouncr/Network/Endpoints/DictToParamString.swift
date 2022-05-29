//
//  DictToParamString.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/29/22.
//

import Foundation

struct DictToParamString {
    
    func toParam(input: [String:String]?)->String{
        var builder = ""
        if let input = input {
            builder.append("?")
            for (k,v) in input{
                builder.append(k)
                builder.append("=")
                builder.append(v)
                builder.append("&")
            }
            return builder
        }
        return ""
    }
}
