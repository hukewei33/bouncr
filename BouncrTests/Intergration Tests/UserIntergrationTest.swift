//
//  UserIntergrationTest.swift
//  BouncrTests
//
//  Created by Kenny Hu on 6/19/22.
//

import XCTest
@testable import Bouncr

class UserIntergrationTest: XCTestCase {

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
    
    //live server test
    
    func testLoginServer() throws {
        let controller = MainController()
        
        let expectation = expectation(description: "login to service")
        
        controller.login(username: "khu", password: "secret") {
            
            XCTAssertEqual(controller.token, "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU")
            XCTAssertEqual(controller.thisUser!.username, "khu")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    
    
    func testCreateServer() throws {
        let controller = MainController()

        let expectation = expectation(description: "login to service after creation")
        let testUser = User(id: 1, firstName: "tester", lastName: "macTest", email: "test", username: "newperson", phoneNumber: 1, birthday: Date(), orgUser: nil, password: "secret", token: nil)

        controller.createUser(newUser: testUser){
            expectation.fulfill()
            XCTAssertEqual(controller.thisUser!.username, "newperson")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    
    func testUpdateServer() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        
        let expectation = expectation(description: "login to service after creation")
        
        let testUser = User(id: 1, firstName: "test", lastName: "test", email: "testChangedTothis", username: "khu", phoneNumber: 1, birthday: Date(), orgUser: nil, password: "secret", token: nil)
        
        controller.updateUser(updatedUser: testUser){
            expectation.fulfill()
            XCTAssertEqual(controller.thisUser!.email, "testChangedTothis")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }

}
