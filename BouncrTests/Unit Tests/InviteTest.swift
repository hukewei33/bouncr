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
    
    //mock tests
    
    func testInvitesServiceMockGet() async {
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
    
    func testInviteServiceMockCreate() async {
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
    
    func testInviteServiceMockUpdate() async {
        let mock = InviteServiceMock()
        let res = try await mock.updateInvite( id: 1, newInvite: nil, token: "")
        
        switch res {
        case .success(let Invite):
            XCTAssertEqual(Invite.id,3)
            XCTAssertEqual(Invite.user_id,2)
            
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testInviteServiceMockDelete() async {
        let mock = InviteServiceMock()
        let res = try await mock.deleteInvite( id: 1, token: "")
        
        switch res {
        case .success(let r):
            XCTAssertEqual(r.returnValue,0)
            XCTAssertEqual(r.returnString,"ok")
            
        case .failure:
            XCTFail("The request should not fail")
        }
        let res1 = try await mock.deleteInvite( id: -1, token: "")
        
        switch res1 {
        case .success(let r):
            XCTAssertEqual(r.returnValue,-1)
            XCTAssertEqual(r.returnString,"fail")
            
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    //controller tests
    func testGetInvites() throws {
        let controller = InviteController(service: InviteServiceMock())
        
        let expectation = expectation(description: "get all invites")
        
        controller.getInvites(){
            
            XCTAssertEqual(controller.InviteArray.count,2)
            XCTAssertEqual(controller.InviteArray[0].id,3)
            //XCTAssertEqual(controller.InviteArray[0].event?.id,1)
            XCTAssertEqual(controller.InviteArray[1].id,2)
            //XCTAssertEqual(controller.InviteArray[1].user?.id,2)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    
    
    func testCreateInvite() throws {
        let controller = InviteController(service: InviteServiceMock())
        
        let expectation = expectation(description: "create invites")
        
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
        
        let expectation = expectation(description: "update invites")
        
        let newInvite = Invite(id: 1, user_id: 1, event_id: 1, checkinTime: nil, inviteStatus: true, coverChargePaid: 0.0, event: nil, user: nil)
        controller.updateInvite(updatedInvite: newInvite){
            expectation.fulfill()
            XCTAssertEqual(controller.InviteShowed?.event?.name,"event1")
            XCTAssertEqual(controller.InviteShowed?.id,3)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testDeleteInvite() throws {
        let controller = InviteController(service: InviteServiceMock())
        
        let expectation = expectation(description: "delete invites")
        
        controller.deleteInvite(deletedInviteID: 1){
            //expectation.fulfill()
            XCTAssertEqual(controller.statusMessage,"ok")
        }
        controller.deleteInvite(deletedInviteID: -1){
            expectation.fulfill()
            XCTAssertEqual(controller.statusMessage,"fail")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    //server tests
    
    func testGetInvitesServer() throws {
        let controller = InviteController()
        
        let expectation = expectation(description: "get all invites")
        
        controller.getInvites(){
            XCTAssertEqual(controller.InviteArray.count,2)
            //XCTAssertEqual(controller.InviteArray[0].id,4)
            //XCTAssertEqual(controller.InviteArray[0].event?.id,2)
            //XCTAssertEqual(controller.InviteArray[1].id,13)
            //XCTAssertEqual(controller.InviteArray[1].user?.id,5)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testCreateInviteServer() throws {
        let controller = InviteController()
        
        let expectation = expectation(description: "create invite")
        
        let newInvite = Invite(id: 1, user_id: 2, event_id: 2, checkinTime: nil, inviteStatus: false, coverChargePaid: 0.0, event: nil, user: nil)
        controller.createInvite(newInvite: newInvite){
            expectation.fulfill()
            XCTAssertEqual(controller.InviteShowed?.user_id,2)
            XCTAssertEqual(controller.InviteShowed?.event_id,2)
            XCTAssertEqual(controller.InviteShowed?.inviteStatus,false)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testUpdateInviteServer() throws {
        let controller = InviteController()
        
        let expectation = expectation(description: "update invites")
        
        let newInvite = Invite(id: 2, user_id: 2, event_id: 2, checkinTime: nil, inviteStatus: true, coverChargePaid: 69.69, event: nil, user: nil)
        controller.updateInvite(updatedInvite: newInvite){
            expectation.fulfill()
            XCTAssertEqual(controller.InviteShowed?.user_id,2)
            XCTAssertEqual(controller.InviteShowed?.event_id,2)
            XCTAssertEqual(controller.InviteShowed?.inviteStatus,true)
            XCTAssertEqual(controller.InviteShowed?.coverChargePaid,69.69)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testDeleteInviteServer() throws {
        let controller = InviteController()
        
        let expectation = expectation(description: "delete invites")
        
        controller.deleteInvite(deletedInviteID: 1){
            expectation.fulfill()
            XCTAssertEqual(controller.statusMessage,"ok")
        }
//        controller.deleteInvite(deletedInviteID: -1){
//            expectation.fulfill()
//            XCTAssertEqual(controller.statusMessage,"fail")
//        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    
    
}
