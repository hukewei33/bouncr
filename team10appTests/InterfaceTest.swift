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
        let user = User("userkey")
        
        // When...
        user.fetch { (users) in
            XCTAssertEqual(users.first?.firstname, "testval")
            XCTAssertEqual(users.first?.lastname, "testval")
            XCTAssertEqual(users.first?.itemDescription, "testval")
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateUser() {
        
        // Given...
        let user = User("userkey")
        let newUserID = user.create(firstName: "testval", lastName : "testval", email: "testval", passwordHash: "testval" , username: "testval")
            // When...
            user.fetch { (users) in
                let onlyNewUser = users.filter {$0.key == newUserID}
                XCTAssertEqual(onlyNewUser.first?.firstname, "testval")
                XCTAssertEqual(onlyNewUser.first?.lastname, "testval")
                XCTAssertEqual(onlyNewUser.first?.itemDescription, "testval")
                self.expectation.fulfill()
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateUser() {
        
        // Given...
        let user = User("userkey")
        user.update(key: "userkey",updateVals: ["firstName": "testchanged"] )
        // When...
        user.fetch { (users) in
            let onlyUpdatedUser = users.filter {$0.key == "userkey"}
            XCTAssertEqual(onlyUpdatedUser.first?.firstname, "testchanged")
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeteteUser() {
        
        // Given...
        let user = User("userkey")
        user.delete(key: "useKeyToDel")
        
        // When...
        user.fetch { (users) in
            let onlyUpdatedUser = users.filter {$0.key == "useKeyToDel"}
            XCTAssertEqual(onlyUpdatedUser.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_ParseFirstEvent() {
        
        // Given...
        let event = Event()
        
        // When...
        event.fetch { (events) in
            XCTAssertEqual(event.first?.name, "testval")
            XCTAssertEqual(event.first?.street1, "testval")
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateEvent() {
        let event = Event()
        let newEventID = event.create(name: "testval", startTime: Date, street1: "testval", city: "testval", state: "testval", zip: "testval")
        event.fetch { (events) in
                let onlyNewEvent = events.filter {$0.key == newEventID}
                XCTAssertEqual(onlyNewEvent.first?.name, "testval")
                XCTAssertEqual(onlyNewEvent.first?.street1, "testval")
                self.expectation.fulfill()
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateEvent() {
        let event = Event()
        event.update(key: "eventkey",updateVals: ["nameame": "testchanged"] )
        // When...
        event.fetch { (events) in
            let onlyUpdatedEvent = events.filter {$0.key == "userkey"}
            XCTAssertEqual(onlyUpdatedEvent.first?.name, "testchanged")
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeleteEvent() {
        let event = Event()
        event.delete(key: "useKeyToDel")
        
        // When...
        event.fetch { (events) in
            let updated = events.filter {$0.key == "useKeyToDel"}
            XCTAssertEqual(updated.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_ParseFirstInvite() {
        
        // Given...
        let interface = Invite()
        
        // When...
        interface.fetch { (list) in
            XCTAssertEqual(list.first?.eventKey, "testval")
            XCTAssertEqual(list.first?.userKey, "testval")
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateInvite() {
        let interface = Invite()
        let newID = interface.create(eventKey: "testval",userKey: "testval")
        interface.fetch { (list) in
                let newList = events.filter {$0.key == newID}
            XCTAssertEqual(newList.first?.eventKey, "testval")
            XCTAssertEqual(newList.first?.userKey, "testval")
                self.expectation.fulfill()
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateInvite() {
        let interface = Invite()
        interface.update(key: "key",updateVals: ["userKey": "testchanged"] )
        // When...
        interface.fetch { (list) in
            let newList = events.filter {$0.key == "key"}
            XCTAssertEqual(onlyUpdatedEvent.first?.userKey, "testchanged")
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeleteInvite() {
        let interface = Invite()
        interface.delete(key: "useKeyToDel")
        
        // When...
        interface.fetch { (list) in
            let newList = events.filter {$0.key == newID}
            XCTAssertEqual(updated.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_ParseFirstHost() {
        
        // Given...
        let interface = Host()
        
        // When...
        interface.fetch { (list) in
            XCTAssertEqual(list.first?.eventKey, "testval")
            XCTAssertEqual(list.first?.userKey, "testval")
            self.expectation.fulfill()
        }

        waitForExpectations(timeout: expired)
        
    }
    
    func test_CreateHost() {
        let interface = Host()
        let newID = interface.create(eventKey: "testval",userKey: "testval")
        interface.fetch { (list) in
                let newList = events.filter {$0.key == newID}
            XCTAssertEqual(newList.first?.eventKey, "testval")
            XCTAssertEqual(newList.first?.userKey, "testval")
                self.expectation.fulfill()
            }
        waitForExpectations(timeout: expired)
        
    }
    
    func test_UpdateHost() {
        let interface = Host()
        interface.update(key: "key",updateVals: ["userKey": "testchanged"] )
        // When...
        interface.fetch { (list) in
            let newList = events.filter {$0.key == "key"}
            XCTAssertEqual(onlyUpdatedEvent.first?.userKey, "testchanged")
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    func test_DeleteHost() {
        let interface = Host()
        interface.delete(key: "useKeyToDel")
        
        // When...
        interface.fetch { (list) in
            let newList = events.filter {$0.key == newID}
            XCTAssertEqual(updated.count, 0)
            self.expectation.fulfill()
        }
        
        // Wait how long...
        waitForExpectations(timeout: expired)
        
    }
    
    
    
}
