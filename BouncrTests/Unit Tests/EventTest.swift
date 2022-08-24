//
//  EventTest.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/11/22.
//

import XCTest
@testable import Bouncr

class EventTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEventsServiceMock() async {
        let mock = EventServiceMock()
        let res = try await mock.getHostEvents(id: 1, token: "")
        
        switch res {
        case .success(let resArray):
            XCTAssertEqual(resArray.count,2)
            XCTAssertEqual(resArray[0].name,"event1")
            XCTAssertEqual(resArray[1].name,"event2")
            
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testGetEvents() throws {
        let controller = HostedEventController(service: EventServiceMock())
        
        let expectation = expectation(description: "get all friends")
        
        
        controller.getHostedEvents(){
            expectation.fulfill()
            XCTAssertEqual(controller.eventArray.count,2)
            XCTAssertEqual(controller.eventArray[0].name,"event1")
            XCTAssertEqual(controller.eventArray[1].name,"event2")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testEventServiceMock() async {
        let mock = EventServiceMock()
        let res = try await mock.createEventWithHost(id: 1, newEvent: nil, token: "")
        
        switch res {
        case .success(let event):
            XCTAssertEqual(event.id,2)
            XCTAssertEqual(event.name,"Art Night")
            
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testCreateEvent() throws {
        let controller = HostedEventController(service: EventServiceMock())
        
        let expectation = expectation(description: "get all friends")
        
        let newEvent = Event(id: 1, name: "", startTime: Date(), endTime: Date(), street1: "", street2: nil, city: "", state: "", zip: 1, description: nil, attendenceVisible: true, friendsAttendingVisible: false, attendenceCap: 32, coverCharge: 42.2, isOpenInvite: false, venueLatitude: 1.1, venueLongitude: 2.2, organizations: nil, acceptedInvitesCount: nil, checkedInInvitesCount: nil)
        controller.createEvent(newEvent: newEvent){
            expectation.fulfill()
            XCTAssertEqual(controller.eventShowed?.name,"Art Night")
            XCTAssertEqual(controller.eventShowed?.id,2)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testUpdateEvent() throws {
        let controller = HostedEventController(service: EventServiceMock())
        
        let expectation = expectation(description: "get all friends")
        
        let newEvent = Event(id: 1, name: "", startTime: Date(), endTime: Date(), street1: "", street2: nil, city: "", state: "", zip: 1, description: nil, attendenceVisible: true, friendsAttendingVisible: false, attendenceCap: 32, coverCharge: 42.2, isOpenInvite: false, venueLatitude: 1.1, venueLongitude: 2.2, organizations: nil, acceptedInvitesCount: nil, checkedInInvitesCount: nil)
        
        
        controller.updateEvent(updatedEvent: newEvent){
            expectation.fulfill()
            XCTAssertEqual(controller.eventShowed?.name,"Art Night")
            XCTAssertEqual(controller.eventShowed?.id,2)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testDeleteEventOK() throws {
        let controller = HostedEventController(service: EventServiceMock())
        
        let expectation = expectation(description: "delete Events")
        
        controller.deleteEvent(deletedEventID: 1){
            
            XCTAssertEqual(controller.statusMessage,"ok")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    func testDeleteEventFail() throws {
        let controller = HostedEventController(service: EventServiceMock())
        
        let expectation = expectation(description: "delete Events")
        
        
        controller.deleteEvent(deletedEventID: -1){
            expectation.fulfill()
            XCTAssertEqual(controller.statusMessage,"fail")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    
    
    
}
