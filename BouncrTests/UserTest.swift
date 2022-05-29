//
//  UserMock.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/1/22.
//

import XCTest
@testable import Bouncr

class UserTest: XCTestCase {
    
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
    
    func testUserServiceMockLogin() async {
        let mock = UserServiceMock()
        let res = try await mock.userLogin(username: "", password: "")
        
        switch res {
        case .success(let login):
            XCTAssertEqual(login.token, "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU")
            XCTAssertEqual(login.user.username, "khu")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testUserServiceMockCreate() async {
        let mock = UserServiceMock()
        let testUser = User(id: 1, firstName: "test", lastName: "test", email: "test", username: "test", phoneNumber: 1, birthday: Date(), orgUser: nil, password: nil)
        let res = try await mock.createUser(newUser: testUser.toDict())
        
        switch res {
        case .success(let login):
            XCTAssertEqual(login.token, "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU")
            XCTAssertEqual(login.user.username, "khu")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testLogin() throws {
        let controller = MainController(service: UserServiceMock())
        
        let expectation = expectation(description: "login to service")
        
        controller.login(username: "khu", password: "secret") {
            expectation.fulfill()
            XCTAssertEqual(controller.token, "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU")
            XCTAssertEqual(controller.thisUser!.username, "khu")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testLoginServer() throws {
        let controller = MainController()
        
        let expectation = expectation(description: "login to service")
        
        controller.login(username: "testingUser", password: "secret") {
            expectation.fulfill()
            //XCTAssertEqual(controller.token, "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU")
            XCTAssertEqual(controller.thisUser!.username, "testingUser")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testCreate() throws {
        let controller = MainController(service: UserServiceMock())
        
        let expectation = expectation(description: "login to service after creation")
        let testUser = User(id: 1, firstName: "test", lastName: "test", email: "test", username: "test", phoneNumber: 1, birthday: Date(), orgUser: nil, password: "secret")
        
        
        controller.createUser(newUser: testUser){
            expectation.fulfill()
            XCTAssertEqual(controller.token, "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.4aV9sPAQmgK4hTBPihEXF3CVkzLDz3jsmWShy2TtQfU")
            XCTAssertEqual(controller.thisUser!.username, "khu")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testCreateServer() throws {
        let controller = MainController()

        let expectation = expectation(description: "login to service after creation")
        let testUser = User(id: 1, firstName: "tester", lastName: "macTest", email: "test", username: "tu", phoneNumber: 1, birthday: Date(), orgUser: nil, password: "secret")

        controller.createUser(newUser: testUser){
            expectation.fulfill()
            XCTAssertEqual(controller.thisUser!.username, "testingUser")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testUpdate() throws {
        let controller = MainController(service: UserServiceMock())
        
        let expectation = expectation(description: "login to service after creation")
        let testUser = User(id: 1, firstName: "test", lastName: "test", email: "test", username: "test", phoneNumber: 1, birthday: Date(), orgUser: nil, password: "secret")
        
        controller.updateUser(updatedUser: testUser){
            expectation.fulfill()
            XCTAssertEqual(controller.thisUser!.username, "khu")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testUpdateServer() throws {
        let controller = MainController()
        controller.manualLoginForTesting()
        
        let expectation = expectation(description: "login to service after creation")
        let testUser = User(id: 1, firstName: "test", lastName: "test", email: "testChangedTothis", username: "khu", phoneNumber: 1, birthday: Date(), orgUser: nil, password: "secret")
        
        controller.updateUser(updatedUser: testUser){
            expectation.fulfill()
            XCTAssertEqual(controller.thisUser!.email, "testChangedTothis")
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
}
