//
//  EventServiceMock.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/11/22.
//

import Foundation
@testable import Bouncr


final class EventServiceMock: Mockable, EventServiceable {
    func getHostEvents(id: Int, token: String) async -> Result<[Event], RequestError> {
        return .success(loadJSON(filename: "ReturnEventArray", type: [Event].self))
    }
    
    func createEventWithHost(id: Int, newEvent: [String : String]?, token: String) async -> Result<Event, RequestError> {
        return .success(loadJSON(filename: "ReturnEvent", type: Event.self))
    }
    
    func updateEvent(id: Int, newEvent: [String : String]?, token: String) async -> Result<Event, RequestError> {
        return .success(loadJSON(filename: "ReturnEvent", type: Event.self))
    }
    
    func deleteEvent(id: Int, token: String) async -> Result<GenericResponse, RequestError> {
        if (id == -1){
            return .success(loadJSON(filename: "BadGenericResponse", type: GenericResponse.self))
        }
        return .success(loadJSON(filename: "GoodGenericResponse", type: GenericResponse.self))
    }
        
}
