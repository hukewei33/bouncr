//
//  EventServiceable.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
protocol EventServiceable {
    func getHostEvents(id:Int,token: String)async -> Result<[Event], RequestError>
    func createEventWithHost(id:Int,newEvent: [String:String]?,token: String)async -> Result<Event, RequestError>
    func updateEvent(id:Int,newEvent: [String:String]?,token: String)async -> Result<Event, RequestError>
    func deleteEvent(id:Int,token: String)async -> Result<[Event], RequestError>
}

struct EventService: HTTPClient, EventServiceable {
    
    func getHostEvents(id:Int,token: String)async -> Result<[Event], RequestError> {
        return await sendRequest(endpoint: EventEndpoint.getHostEvents(id:id,token: token), responseModel: [Event].self)
    }
    func createEventWithHost(id:Int,newEvent: [String:String]?,token: String)async -> Result<Event, RequestError> {
        return await sendRequest(endpoint: EventEndpoint.createEventWithHost(id:id, newEvent: newEvent,token: token), responseModel: Event.self)
    }
    func updateEvent(id:Int,newEvent: [String:String]?,token: String)async -> Result<Event, RequestError> {
        return await sendRequest(endpoint: EventEndpoint.updateEvent(id: id, newEvent: newEvent, token: token), responseModel: Event.self)
    }
    //TODO: change return type
    func deleteEvent(id:Int,token: String)async -> Result<[Event], RequestError> {
        return await sendRequest(endpoint: EventEndpoint.deleteEvent(id:id,token: token), responseModel: [Event].self)
    }
}
