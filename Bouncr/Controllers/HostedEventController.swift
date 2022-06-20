//
//  HostedEventController.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/4/22.
//

import Foundation
import SwiftUI


class HostedEventController: HelperController,ObservableObject {
    
    @Published var eventArray:[Event]=[]
    @Published var eventShowed:Event?=nil
    
    let eventService:EventServiceable
    
    init(service:EventServiceable = EventService()){
        eventService=service
    }
    
    func getHostedEvents(completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await eventService.getHostEvents(id: getUserID(), token: getToken())
            setLoading(status: false)
            switch result {
            case .success(let events):
                eventArray=events
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    //the id is ignored and can be anything
    func createEvent(newEvent:Event,completion: (() -> Void)? = nil){
        let newEventDict = newEvent.toDict()
        Task.init{
            setLoading(status: true)
            let result = await eventService.createEventWithHost(id: getUserID(), newEvent: newEventDict, token: getToken())
            setLoading(status: false)
            switch result {
            case .success(let event):
                eventShowed=event
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    func updateEvent(updatedEvent:Event,completion: (() -> Void)? = nil){
        let updatedEventDict = updatedEvent.toDict()
        Task.init{
            setLoading(status: true)
            let result = await eventService.updateEvent(id: updatedEvent.id, newEvent: updatedEventDict, token: getToken())
            setLoading(status: false)
            switch result {
            case .success(let event):
                eventShowed=event
            case .failure(let error):
                print(error.customMessage)
                setStatusMessage(message: error.customMessage)
            }
            completion?()
        }
    }
    
    func deleteEvent(deletedEvent:Event,completion: (() -> Void)? = nil){
        Task.init{
            setLoading(status: true)
            let result = await eventService.deleteEvent(id: deletedEvent.id, token: getToken())
            setLoading(status: false)
            //TODO: change return type
//            switch result {
//            case .success(let event):
//                eventShowed=event
//            case .failure(let error):
//                print(error.customMessage)
//            }
            completion?()
        }
    }
    
    
    
}
