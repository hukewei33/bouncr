//
//  EventIntergrationTest.swift
//  BouncrTests
//
//  Created by Kenny Hu on 6/19/22.
//

import XCTest
@testable import Bouncr

class EventIntergrationTest: XCTestCase {

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
    
    func testGetHostEvents() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get hosted events")
        
        controller.hostedEventController.getHostedEvents(){
            XCTAssertEqual(controller.hostedEventController.eventArray.count,4)
            XCTAssertEqual(controller.hostedEventController.eventArray.first?.name ,"Art Night")
            XCTAssertEqual(controller.hostedEventController.eventArray.first?.acceptedInvitesCount ,2)
            XCTAssertEqual(controller.hostedEventController.eventArray.first?.checkedInInvitesCount ,1)
            XCTAssertEqual(controller.hostedEventController.eventArray.last?.name ,"Kappa Sigma Partay")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        
    }
    
    func testCreateEvent()throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "create hosted events")
        let newEvent = Event(id: -1, name: "newEvent", startTime: Date(), endTime: Date(), street1: "here", street2: "there", city: "happytown", state: "PA", zip: 15213, description: "have fun", attendenceVisible: true, friendsAttendingVisible: true, attendenceCap: 3, coverCharge: 2.2, isOpenInvite: true, venueLatitude: 0.0, venueLongitude: 0.0, organizations: nil, acceptedInvitesCount: nil, checkedInInvitesCount: nil)
        
        controller.hostedEventController.createEvent(newEvent: newEvent){
           XCTAssertEqual(controller.hostedEventController.eventShowed?.name ,"newEvent")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testUpdateEvent()throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "updated hosted events")
        let newEvent = Event(id: 1, name: "newUpdatedEvent", startTime: Date(), endTime: Date(), street1: "here", street2: "there", city: "happytown", state: "PA", zip: 15213, description: "have fun", attendenceVisible: true, friendsAttendingVisible: true, attendenceCap: 3, coverCharge: 2.2, isOpenInvite: true, venueLatitude: 0.0, venueLongitude: 0.0, organizations: nil, acceptedInvitesCount: nil, checkedInInvitesCount: nil)
        
        controller.hostedEventController.updateEvent(updatedEvent: newEvent){
           XCTAssertEqual(controller.hostedEventController.eventShowed?.name ,"newUpdatedEvent")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testDeleteEvent() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        
        let expectation = expectation(description: "delete invites")
        
        controller.hostedEventController.deleteEvent(deletedEventID: 1){
            expectation.fulfill()
            XCTAssertEqual(controller.hostedEventController.statusMessage,"success")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }

}
