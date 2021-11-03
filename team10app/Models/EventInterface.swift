//
//  EventInterface.swift
//  team10app
//
//  Created by Kenny Hu on 10/25/21.
//

import Foundation
import Firebase

class EventInterface {
    
    var Events: [Event] = []
    
    init(){
        self.fetch(){events in return}
    }
    
    let eventsReference = Database.database().reference(withPath: "events")
    
    func create(name: String, startTime: Date, endTime: Date,street1: String, street2: String? = "", city : String, zip: String , state:String, description : String? = "")->String?{
        let keyResult :String? = self.eventsReference.childByAutoId().key
        if let userId = keyResult{
            let newEvent = Event(name: name, startTime: startTime, endTime: endTime, street1: street1, street2: street2, city: city, state: state, zip: zip, description: description, key: userId)
            
            self.eventsReference.child(userId).setValue(newEvent.toAnyObject())
            return userId
        }
        else{
            print("failed to add event")
            return nil
        }        
    }
    
    func fetch(completionHandler: @escaping ([Event]) -> Void){
        self.eventsReference.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
            var newEvents: [Event] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let event = Event(snapshot: snapshot) {
                    //print(event.name)
                    newEvents.append(event)
                }
            }
            self.Events = newEvents
            completionHandler(self.Events)
        })
    }
    
       

    func update(key:String, updateVals:[String : Any]){
        self.eventsReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.eventsReference.child(key).removeValue()
    }
    
}
