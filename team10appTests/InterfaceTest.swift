//
//  InterfaceTest.swift
//  team10appTests
//
//  Created by Kenny Hu on 10/30/21.
//

import Foundation
import XCTest
import Firebase
@testable import team10app




class RepoParsingTests: XCTestCase {
    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    
    override func setUp() {
        expectation = expectation(description: "Able to perform interface calls")
    }
    
    func test_ParseFirstUser() {
        
        // Given...
        let user = UserInterface(userKey: "Sam")
        
        // When...
        user.fetch { (users) in
            XCTAssertEqual(users.first?.firstName, "Dick")
            XCTAssertEqual(users.first?.lastName, "Dickson")
            print(users)
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateUser() {
        
        // Given...
        let user = UserInterface(userKey: "Sam")
        if let newUserID = user.create(firstName: "testval", lastName : "testval", email: "testval", passwordHash: "testval" , username: "testval"){
            user.fetch { (users) in
                print(users)
                let onlyNewUser = users.filter {$0.key == newUserID}
                XCTAssertEqual(onlyNewUser.first?.firstName, "testval")
                XCTAssertEqual(onlyNewUser.first?.lastName, "testval")
                XCTAssertEqual(onlyNewUser.first?.username, "testval")
                self.expectation.fulfill()
                user.delete(key: newUserID)
                }
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateUser() {
        
        // Given...
        let user = UserInterface(userKey: "Sam")
        user.update(key: "Sam",updateVals: ["firstName": "testchanged"] )
        // When...
        user.fetch { (users) in
            let onlyUpdatedUser = users.filter {$0.key == "Sam"}
            XCTAssertEqual(onlyUpdatedUser.first?.firstName, "testchanged")
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeteteUser() {
        
        // Given...
        let user  = UserInterface(userKey: "Sam")
        user.delete(key: "userkey")
        
        // When...
        user.fetch { (users) in
            let onlyUpdatedUser = users.filter {$0.key == "userkey"}
            XCTAssertEqual(onlyUpdatedUser.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_ParseFirstEvent() {
        
        // Given...
        let event = EventInterface()
        
        // When...
        event.fetch { (events) in
            XCTAssertEqual(events.first?.name, "John's party changed")
            XCTAssertEqual(events.first?.street1, "John's street")
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateEvent() {
        let event = EventInterface()
        let newEventID = event.create(name: "testval", startTime: Date(), street1: "testval", city: "testval", zip: "testval", state: "testval")
        event.fetch { (events) in
                let onlyNewEvent = events.filter {$0.key == newEventID}
                XCTAssertEqual(onlyNewEvent.first?.name, "testval")
                XCTAssertEqual(onlyNewEvent.first?.street1, "testval")
                self.expectation.fulfill()
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateEvent() {
        let event = EventInterface()
        event.update(key: "JohnParty",updateVals: ["name": "testchanged"] )
        // When...
        event.fetch { (events) in
            let onlyUpdatedEvent = events.filter {$0.key == "JohnParty"}
            XCTAssertEqual(onlyUpdatedEvent.first?.name, "testchanged")
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeleteEvent() {
        let event = EventInterface()
        event.delete(key: "JohnParty")
        
        // When...
        event.fetch { (events) in
            let updated = events.filter {$0.key == "JohnParty"}
            XCTAssertEqual(updated.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_ParseFirstInvite() {
        
        // Given...
        let interface = InviteInterface()
        
        // When...
        interface.fetch { (list) in
            XCTAssertEqual(list.first?.eventKey, "JohnParty")
            XCTAssertEqual(list.first?.userKey, "Dick")
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateInvite() {
        let interface = InviteInterface()
        let newID = interface.create(userKey: "testval",eventKey: "testval")
        interface.fetch { (list) in
                let newList = list.filter {$0.key == newID}
            XCTAssertEqual(newList.first?.eventKey, "testval")
            XCTAssertEqual(newList.first?.userKey, "testval")
                self.expectation.fulfill()
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateInvite() {
        let interface = InviteInterface()
        interface.update(key: "JohnPartyDick",updateVals: ["checkinStatus": true] )
        // When...
        interface.fetch { (list) in
            let newList = list.filter {$0.key == "JohnPartyDick"}
            XCTAssertEqual(newList.first?.checkinStatus, true)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeleteInvite() {
        let interface = InviteInterface()
        interface.delete(key: "MnNunDKsZ1hiQO16MV1")
        
        // When...
        interface.fetch { (list) in
            let newList = list.filter {$0.key == "MnNunDKsZ1hiQO16MV1"}
            XCTAssertEqual(newList.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_ParseFirstHost() {
        
        // Given...
        let interface = HostInterface(userKey: "JohnPartyJohn")
        
        // When...
        interface.fetch(userKey: "Tom") { (list) in
            //print(list)
            XCTAssertEqual(list.first?.eventKey, "TomParty")
            XCTAssertEqual(list.first?.userKey, "Tom")
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateHost() {
        
        let interface = HostInterface(userKey: "testval")
        let newID = interface.create(userKey: "testval", eventKey: "testval" )
        interface.fetch (userKey: "testval")  { (list) in
            let newList = list.filter {$0.key == newID}
            XCTAssertEqual(newList.first?.eventKey, "testval")
            XCTAssertEqual(newList.first?.userKey, "testval")
            self.expectation.fulfill()
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateHost() {
        let interface = HostInterface(userKey: "testval")
        interface.update(key: "key",updateVals: ["userKey": "testchanged"] )
        // When...
        interface.fetch (userKey: "testVal")  { (list) in
            let newList = list.filter {$0.key == "key"}
            XCTAssertEqual(newList.first?.userKey, "testchanged")
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeleteHost() {
        let interface = HostInterface(userKey: "testval")
        interface.delete(key: "useKeyToDel")
        
        // When...
        interface.fetch (userKey: "testVal")  { (list) in
            let newList = list.filter {$0.key == "useKeyToDel"}
            XCTAssertEqual(newList.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    
    
}
