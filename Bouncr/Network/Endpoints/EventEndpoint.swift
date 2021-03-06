//
//  EventEndpoint.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/5/22.
//

import Foundation
enum EventEndpoint {
    case getHostEvents(id:Int,token: String)
    case createEventWithHost(id:Int,newEvent: [String:String]?,token: String)
    case updateEvent(id:Int,newEvent: [String:String]?,token: String)
    case deleteEvent(id:Int,token: String)

    
}

extension EventEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getHostEvents(let id, _):
            return "host_events?id=\(id)"
        case.createEventWithHost(let id, let newEvent,_):
            print("create_event_with_host"+DictToParamString().toParam(input: newEvent)+"id=\(id)")
            //return "create_event_with_host"+DictToParamString().toParam(input: newEvent)+"id=\(id)"
            return "create_event_with_host?id=\(id)"
        
        case.updateEvent(let id, let newEvent,_):
            print("events/\(id)"+DictToParamString().toParam(input: newEvent))
            return "events/\(id)"
            //return "host_events?id=\(id)"
        //case .updateEvent(let id, let _,_):
            //return "host_events?id=\(id)"
        case .deleteEvent(let id, _):
            return "events/\(id)"

        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createEventWithHost:
            return .post
        case .updateEvent:
            return .patch
        case .deleteEvent:
            return .delete
        default:
            return .get
        }
        
    }
    
    var header: [String: String]? {
        // Access Token to use in Bearer header
        //let accessToken = "Your TMDB Access Token here!!!!!!!"
        switch self {
            
        case .getHostEvents(_,let accessToken),.deleteEvent(_,let accessToken), .createEventWithHost(_,_,let accessToken),.updateEvent(_,_,let accessToken):
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .createEventWithHost(_, let newEvent, _),.updateEvent(_, let newEvent, _):
            return newEvent
        default:
            return nil
        }
    }
}
