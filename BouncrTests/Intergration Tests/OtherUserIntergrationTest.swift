//
//  OtherUserIntergrationTest.swift
//  BouncrTests
//
//  Created by Kenny Hu on 6/20/22.
//

import XCTest
@testable import Bouncr

class OtherUserIntergrationTest: XCTestCase {

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
    
    func testGetFriends() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get friends")
        
        controller.otherUserController.getFriends(){
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"Shane")
            XCTAssertEqual(controller.otherUserController.otherUserArray.last?.firstName ,"Grace")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGetFriendRequestsSent() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get sent friend request")
        
        controller.otherUserController.getPendingSentFriends(){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,1)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.username ,"profh")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGetFriendRequestsRecieved() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get recieved friend request")
        
        controller.otherUserController.getPendingRecievedFriends(){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,3)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"Kenny")
            XCTAssertEqual(controller.otherUserController.otherUserArray.last?.firstName ,"Max")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGetSearch() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get recieved friend request")
        
        controller.otherUserController.getSearch(term: "g"){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,4)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"Grace")
            XCTAssertEqual(controller.otherUserController.otherUserArray.last?.firstName ,"Max")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGetEventHost() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get recieved friend request")
        
        controller.otherUserController.getHosts(eventID: 1){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,1)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"Prof")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGeteventGuests1() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get recieved friend request")
        
        controller.otherUserController.getGuests(eventID: 5, checkedin: false, inviteStatus: false, isFriend: false){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,2)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"John")
            XCTAssertEqual(controller.otherUserController.otherUserArray.last?.firstName ,"Prof")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGeteventGuests2() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get recieved friend request")
        
        controller.otherUserController.getGuests(eventID: 5, checkedin: false, inviteStatus: true, isFriend: false){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,1)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"Kenny")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGeteventGuests3() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get recieved friend request")
        
        controller.otherUserController.getGuests(eventID: 1, checkedin: true, inviteStatus: true, isFriend: false){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,1)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"Kenny")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGeteventGuests4() throws{
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "get recieved friend request")
        
        controller.otherUserController.getGuests(eventID: 2, checkedin: true, inviteStatus: true, isFriend: true){
            XCTAssertEqual(controller.otherUserController.otherUserArray.count,1)
            XCTAssertEqual(controller.otherUserController.otherUserArray.first?.firstName ,"Shane")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testMakeFriend() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "create friend")
        controller.otherUserController.sendFriendRequest(recieverID: 1){
            XCTAssertEqual(controller.otherUserController.statusMessage,"success")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testAcceptFriend() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "create friend")
        controller.otherUserController.processFriendRequest(senderID: 2, accept: true){
            XCTAssertEqual(controller.otherUserController.statusMessage,"success")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testDeletefriend() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        let expectation = expectation(description: "delete friend")
        controller.otherUserController.deleteFriendRequest(senderID: 4, recieverID: 1){
            XCTAssertEqual(controller.otherUserController.statusMessage,"success")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    

}
