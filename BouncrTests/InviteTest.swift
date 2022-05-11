//
//  InviteTest.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/11/22.
//

import XCTest
@testable import Bouncr

class InviteTest: XCTestCase {
    
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
    
    func testInvitesServiceMock() async {
        let mock = InviteServiceMock()
        let res = try await mock.getInvites(id: 1, token: "String")
        
        switch res {
        case .success(let resArray):
            XCTAssertEqual(resArray.count,2)
            XCTAssertEqual(resArray[0].id,3)
            XCTAssertEqual(resArray[1].id,2)
            
        case .failure:
            XCTFail("The request should not fail")
            
        }
    }
    
    func testGetInvites() throws {
        let controller = InviteController(service: InviteServiceMock())
        
        let expectation = expectation(description: "get all friends")
        
        controller.getInvites(){
            expectation.fulfill()
            XCTAssertEqual(controller.InviteArray.count,2)
            XCTAssertEqual(controller.InviteArray[0].id,3)
            XCTAssertEqual(controller.InviteArray[0].event?.id,1)
            XCTAssertEqual(controller.InviteArray[1].id,2)
            XCTAssertEqual(controller.InviteArray[1].user?.id,2)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testInviteServiceMock() async {
        let mock = InviteServiceMock()
        let res = try await mock.createInvite( newInvite: nil, token: "")
        
        switch res {
        case .success(let Invite):
            XCTAssertEqual(Invite.id,3)
            XCTAssertEqual(Invite.user_id,2)
            
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testCreateInvite() throws {
        let controller = InviteController(service: InviteServiceMock())
        
        let expectation = expectation(description: "get all friends")
        
        let newInvite = Invite(id: 1, user_id: 1, event_id: 1, checkinTime: nil, inviteStatus: true, coverChargePaid: 0.0, event: nil, user: nil)
        controller.createInvite(newInvite: newInvite){
            expectation.fulfill()
            XCTAssertEqual(controller.InviteShowed?.event?.name,"event1")
            XCTAssertEqual(controller.InviteShowed?.id,3)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testUpdateInvite() throws {
        let controller = InviteController(service: InviteServiceMock())
        
        let expectation = expectation(description: "get all friends")
        
        let newInvite = Invite(id: 1, user_id: 1, event_id: 1, checkinTime: nil, inviteStatus: true, coverChargePaid: 0.0, event: nil, user: nil)
        controller.updateInvite(updatedInvite: newInvite){
            expectation.fulfill()
            XCTAssertEqual(controller.InviteShowed?.event?.name,"event1")
            XCTAssertEqual(controller.InviteShowed?.id,3)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
}
