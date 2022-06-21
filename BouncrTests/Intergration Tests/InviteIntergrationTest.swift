//
//  InviteIntergrationTest.swift
//  BouncrTests
//
//  Created by Kenny Hu on 6/20/22.
//

import XCTest
@testable import Bouncr

class InviteIntergrationTest: XCTestCase {

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
    
    //server tests
    
    func testGetInvitesServer() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get all invites")
        
        controller.inviteController.getInvites(){
            XCTAssertEqual(controller.inviteController.InviteArray.count,2)
            XCTAssertEqual(controller.inviteController.InviteArray[0].id,9)
            XCTAssertEqual(controller.inviteController.InviteArray[0].event?.id,4)
            XCTAssertEqual(controller.inviteController.InviteArray[1].id,17)
            XCTAssertEqual(controller.inviteController.InviteArray[1].user_id,4)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testCreateInviteServer() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        
        let expectation = expectation(description: "create invite")
        
        let newInvite = Invite(id: 1, user_id: 2, event_id: 2, checkinTime: nil, inviteStatus: false, coverChargePaid: 0.0, event: nil, user: nil)
        controller.inviteController.createInvite(newInvite: newInvite){
            expectation.fulfill()
            XCTAssertEqual(controller.inviteController.InviteShowed?.user_id,2)
            XCTAssertEqual(controller.inviteController.InviteShowed?.event_id,2)
            XCTAssertEqual(controller.inviteController.InviteShowed?.inviteStatus,false)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testUpdateInviteServer() throws {

        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "update invites")
        
        let newInvite = Invite(id: 2, user_id: 2, event_id: 2, checkinTime: nil, inviteStatus: true, coverChargePaid: 69.69, event: nil, user: nil)
        controller.inviteController.updateInvite(updatedInvite: newInvite){
            expectation.fulfill()
            XCTAssertEqual(controller.inviteController.InviteShowed?.user_id,2)
            XCTAssertEqual(controller.inviteController.InviteShowed?.event_id,2)
            XCTAssertEqual(controller.inviteController.InviteShowed?.inviteStatus,true)
            XCTAssertEqual(controller.inviteController.InviteShowed?.coverChargePaid,69.69)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testDeleteInviteServer() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        
        let expectation = expectation(description: "delete invites")
        
        controller.inviteController.deleteInvite(deletedInviteID: 1){
            expectation.fulfill()
            XCTAssertEqual(controller.inviteController.statusMessage,"success")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
