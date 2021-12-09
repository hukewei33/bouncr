//
//  team10appTests.swift
//  team10appTests
//
//  Created by Kenny Hu on 10/28/21.
//
import XCTest
import Foundation

import Firebase
@testable import team10app

class team10appTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserModel(){
        let newUser = User(firstName: "testfirstName",
                           lastName: "testlastName",
                           email:"testemail",
                           username:  "testusername",
                           profilePicURL: nil ,
                           passwordHash: "1",
                           key: "testinguserId"
        )
        let converted = newUser.toAnyObject() as? NSDictionary
        if let firstname = converted?["firstname"] as? String{
            XCTAssertEqual(firstname, "testfirstName")
        }
        if let lastName = converted?["lastName"] as? String{
            XCTAssertEqual(lastName, "testlastName")
        }
        if let email = converted?["email"] as? String{
            XCTAssertEqual(email, "testemail")
        }
        if let username = converted?["username"] as? String{
            XCTAssertEqual(username, "testusername")
        }
        if let profilePicURL = converted?["profilePicURL"] as? String{
            XCTAssertEqual(profilePicURL, nil)
        }
        if let passwordHash = converted?["passwordHash"] as? String{
            XCTAssertEqual(passwordHash, "1")
        }
        if let key = converted?["key"] as? String{
            XCTAssertEqual(key, "testinguserId")
        }
        //self.expectation.fulfill()
    }
    
    func testEventModel(){
        
        let curTime1 = Date()
        let curTime2 = Date()
        let newEvent = Event(name: "testname", startTime: curTime1 , endTime: curTime2, street1: "teststreet1", street2: "teststreet2", city: "testcity", state: "pa", zip: "12345", description: "testdescription", key: "testeventId",attendenceVisible:true,friendsAttendingVisible:false)
        
        
        let converted = newEvent.toAnyObject() as? NSDictionary
        if let name = converted?["name"] as? String{
            XCTAssertEqual(name, "testname")
        }
        if let startTime = converted?["startTime"] as? Double{
            XCTAssertEqual(startTime, curTime1 .timeIntervalSinceReferenceDate)
        }
        if let endTime = converted?["endTime"] as? Double{
            XCTAssertEqual(endTime, curTime2.timeIntervalSinceReferenceDate)
        }
        if let street1 = converted?["street1"] as? String{
            XCTAssertEqual(street1, "teststreet1")
        }
        if let street2 = converted?["street2"] as? String{
            XCTAssertEqual(street2, "teststreet2")
        }
        if let city = converted?["city"] as? String{
            XCTAssertEqual(city, "testcity")
        }
        if let state = converted?["state"] as? String{
            XCTAssertEqual(state, "pa")
        }
        if let zip = converted?["zip"] as? String{
            XCTAssertEqual(zip, "12345")
        }
        if let description = converted?["description"] as? String{
            XCTAssertEqual(description, "testdescription")
        }
        if let attendenceVisible = converted?["attendenceVisible"] as? Bool{
            XCTAssertEqual(attendenceVisible, true)
        }
        if let friendsAttendingVisible = converted?["friendsAttendingVisible"] as? Bool{
            XCTAssertEqual(friendsAttendingVisible, false)
        }
        if let key = converted?["key"] as? String{
            XCTAssertEqual(key, "testeventId")
        }
    }
    
    func testInviteModel(){
        let newInvite = Invite(userKey: "testuserKey",
                               eventKey: "testeventKey",
                               key: "testId")
        let converted = newInvite.toAnyObject() as? NSDictionary
        if let userKey = converted?["userKey"] as? String{
            XCTAssertEqual(userKey, "testuserKey")
        }
        if let eventKey = converted?["eventKey"] as? String{
            XCTAssertEqual(eventKey, "testeventKey")
        }
        if let inviteStatus = converted?["inviteStatus"] as? Bool{
            XCTAssertEqual(inviteStatus, false)
        }
        if let checkinStatus = converted?["checkinStatus"] as? Bool{
            XCTAssertEqual(checkinStatus, false)
        }
        if let checkinTime = converted?["checkinTime"] as? Double?{
            XCTAssertEqual(checkinTime, nil)
        }
        
        if let key = converted?["key"] as? String{
            XCTAssertEqual(key, "testId")
        }
    }
    
    func testHostModel(){
        let newHost = Host(userKey: "testuserKey" ,
                           eventKey:"testeventKey",
                           key : "testhostId")
        let converted = newHost.toAnyObject() as? NSDictionary
        if let userKey = converted?["userKey"] as? String{
            XCTAssertEqual(userKey, "testuserKey")
        }
        if let eventKey = converted?["eventKey"] as? String{
            XCTAssertEqual(eventKey, "testeventKey")
        }
        
        if let key = converted?["key"] as? String{
            XCTAssertEqual(key, "testhostId")
        }
    }
    
    func testFriendModel(){
        let newFriend = Friend(userKey1: "testuserKey1" ,
                               userKey2:"testuserKey2",
                               key: "testFriendId",
                               originUserId:"testuserKey1"
                                    )
        let converted = newFriend.toAnyObject() as? NSDictionary
        if let userKey1 = converted?["userKey1"] as? String{
            XCTAssertEqual(userKey1, "testuserKey1")
        }
        if let userKey2 = converted?["userKey2"] as? String{
            XCTAssertEqual(userKey2, "testuserKey2")
        }
        
        if let key = converted?["key"] as? String{
            XCTAssertEqual(key, "testFriendId")
        }
        if let originUserId = converted?["originUserId"] as? String{
            XCTAssertEqual(originUserId, "testuserKey1")
        }
    }

}
