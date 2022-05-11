//
//  OtherUserTest.swift
//  BouncrTests
//
//  Created by Kenny Hu on 5/10/22.
//

import XCTest
@testable import Bouncr

class OtherUserTest: XCTestCase {

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
    
    func testOtherUserServiceMock() async {
        let mock = OtherUserServiceMock()
        let res = try await mock.getFriends(id: 1, token: "")
            
        switch res {
        case .success(let resArray):
            XCTAssertEqual(resArray.count,5)
            XCTAssertEqual(resArray[0].id,1)

        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testGetFriends() throws {
        let controller = OtherUserController(service: OtherUserServiceMock())
        
        let expectation = expectation(description: "get all friends")
             
        
        controller.getFriends(){
            expectation.fulfill()
            XCTAssertEqual(controller.otherUserArray.count,5)
            XCTAssertEqual(controller.otherUserArray[0].id,1)
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }

}
