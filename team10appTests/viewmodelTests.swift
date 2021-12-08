//
//  viewModelTests.swift
//  team10appTests
//
//  Created by Kenny Hu on 11/29/21.
//
import XCTest
import Foundation
import Firebase
@testable import team10app

class viewModelTests: XCTestCase {
    let testViewModel = ViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //set up context
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let newUser1 = User(firstName: "testfirstName",
                            lastName: "testlastName",
                            email:"testemail",
                            username:  "assistantregionalmanager",
                            profilePicURL: nil ,
                            passwordHash: "examplepw",
                            key: "Dwight"
        )
        let newUser2 = User(firstName: "testfirstName",
                            lastName: "testlastName",
                            email:"testemail",
                            username:  "jim",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "Jim"
        )
        let newUser3 = User(firstName: "testfirstName",
                            lastName: "testlastName",
                            email:"testemail",
                            username:  "testusername",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "Tom"
        )
        let newUser4 = User(firstName: "testfirstName",
                            lastName: "testlastName",
                            email:"testemail",
                            username:  "john",
                            profilePicURL: nil ,
                            passwordHash: "123",
                            key: "John"
        )
        self.testViewModel.users.removeAll()
        self.testViewModel.users.append(newUser1)
        self.testViewModel.users.append(newUser2)
        self.testViewModel.users.append(newUser3)
        self.testViewModel.users.append(newUser4)
        let curTime1 = Date() + (25 * 60)
        let curTime2 = Date() + (35 * 60)
        let curTime3 = Date() - (25 * 60)
        let curTime4 = Date() + (25 * 60)
        let newEvent1 = Event(name: "event1", startTime: curTime1 , endTime: curTime2, street1: "teststreet1", street2: "teststreet2", city: "testcity", state: "pa", zip: "12345", description: "testdescription", key: "testeventId1",attendenceVisible:true,friendsAttendingVisible:false)
        let newEvent2 = Event(name: "event2", startTime: curTime3 , endTime: curTime4, street1: "teststreet1", street2: "teststreet2", city: "testcity", state: "pa", zip: "12345", description: "testdescription", key: "testeventId2",attendenceVisible:true,friendsAttendingVisible:false)
        self.testViewModel.events.removeAll()
        self.testViewModel.events.append(newEvent1)
        self.testViewModel.currentEvents.append(newEvent2)
        
        let newInvite1 = Invite(userKey: "Dwight",
                                eventKey: "testeventId1",
                                key: "testinvite1")
        let newInvite2 = Invite(userKey: "Jim",
                                eventKey: "testeventId1",
                                key: "testinvite2")
        let newInvite3 = Invite(userKey: "Tom",
                                eventKey: "testeventId2",
                                key: "testinvite3")
        var  newInvite4 = Invite(userKey: "John",
                                eventKey: "testeventId1",
                                key: "testinvite4")
        newInvite4.inviteStatus = true
        var  newInvite5 = Invite(userKey: "John",
                                eventKey: "testeventId2",
                                key: "testinvite5")
        newInvite5.inviteStatus = true
        self.testViewModel.invites.removeAll()
        self.testViewModel.invites.append(newInvite1)
        self.testViewModel.invites.append(newInvite2)
        self.testViewModel.invites.append(newInvite3)
        self.testViewModel.invites.append(newInvite4)
        self.testViewModel.invites.append(newInvite5)
        self.testViewModel.pendingInvites.removeAll()
        self.testViewModel.pendingInvites.append(newInvite1)
        self.testViewModel.pendingInvites.append(newInvite2)
        self.testViewModel.pendingInvites.append(newInvite3)
        let newFriend1 = Friend(userKey1: "testuserKey1" ,
                                userKey2:"Jim",
                                key: "testFriendId1",
                                originUserId: "testuserKey1")
        let newFriend2 = Friend(userKey1: "testuserKey1" ,
                                userKey2:"John",
                                key: "testFriendId2",
                                originUserId: "testuserKey1")
        self.testViewModel.friends.removeAll()
        self.testViewModel.friends.append(newFriend1)
        self.testViewModel.friends.append(newFriend2)
        let newHost1 = Host(userKey: "Dwight" ,
                            eventKey:"testeventId2",
                            key : "testhostId1")
        let newHost2 = Host(userKey: "Jim" ,
                            eventKey:"testeventId2",
                            key : "testhostId2")
        let newHost3 = Host(userKey: "John" ,
                            eventKey:"testeventId1",
                            key : "testhostId3")
        let newHost4 = Host(userKey: "John" ,
                            eventKey:"testeventId2",
                            key : "testhostId4")
        
        self.testViewModel.hosts.removeAll()
        self.testViewModel.hosts.append(newHost1)
        self.testViewModel.hosts.append(newHost2)
        self.testViewModel.hosts.append(newHost3)
        self.testViewModel.hosts.append(newHost4)
        //}
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_login(){
        //let testViewModel = ViewModel()
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        XCTAssertEqual(self.testViewModel.login(username: "assistantregionalmanager", pword: "examplepw1"), false)
        XCTAssertEqual(self.testViewModel.login(username: "assistantregionalmanager", pword: "examplepw"), true)
        XCTAssertEqual(self.testViewModel.thisUser?.username, "assistantregionalmanager")
        //}
    }
    
    func test_loggedin(){
        //let testViewModel = ViewModel()
        XCTAssertEqual(self.testViewModel.loggedin(), nil)
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        XCTAssertEqual(self.testViewModel.login(username: "assistantregionalmanager", pword: "examplepw"), true)
        XCTAssertEqual(self.testViewModel.loggedin() ,"Dwight")
        //}
    }
    
    func test_logout(){
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        XCTAssertEqual(self.testViewModel.login(username: "assistantregionalmanager", pword: "examplepw"), true)
        self.testViewModel.logout()
        XCTAssertEqual(self.testViewModel.loggedin(), nil)
        //}
    }
    
    func test_indexEventGuests(){
        
        let res = self.testViewModel.indexEventGuests(eventKey: "testeventId1")
        XCTAssertEqual(self.testViewModel.indexEventGuests(eventKey: "testeventId1").count, 3)
        XCTAssertEqual(res.first?.key, "Dwight")
        XCTAssertEqual(res.last?.key, "John")
        let res1 = self.testViewModel.indexEventGuests(eventKey: "testeventId2")
        XCTAssertEqual(res1.first?.key, "Tom")
        //}
    }
    
    func test_getEventAttendence(){
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let res = self.testViewModel.getEventAttendence(eventKey: "testeventId1")
        XCTAssertEqual(res,[0,5])
        self.testViewModel.invites[0].checkinStatus = true
        let res1 = self.testViewModel.getEventAttendence(eventKey: "testeventId1")
        XCTAssertEqual(res1,[1,5])
        let res2 = self.testViewModel.getEventAttendence(eventKey: "testeventId2")
        XCTAssertEqual(res2,[0,3])
        
        //}
    }
    
    func test_getAttendingFriends(){
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let res = self.testViewModel.getAttendingFriends(eventKey: "testeventId1")
        XCTAssertEqual(res.first?.key, "Jim")
        XCTAssertEqual(res.last?.key, "John")
        let res1 = self.testViewModel.getAttendingFriends(eventKey: "testeventId2")
        XCTAssertEqual(res1.first?.key, "John")
        //}
    }
    
    func test_indexEventHosts(){
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let res = self.testViewModel.indexEventHosts(eventKey: "testeventId2")
        XCTAssertEqual(res.count, 3)
        XCTAssertEqual(res.first?.key, "Dwight")
        XCTAssertEqual(res.last?.key, "John")
        //}
    }
    
    func test_addPotentialInvite(){
        XCTAssertEqual(self.testViewModel.toBeInvited.count, 0)
        let newUser = User(firstName: "testfirstName",
                           lastName: "testlastName",
                           email:"testemail",
                           username:  "testusername",
                           profilePicURL: nil ,
                           passwordHash: "1",
                           key: "testinguserId"
        )
        self.testViewModel.addPotentialInvite(user: newUser)
        XCTAssertEqual(self.testViewModel.toBeInvited.count, 1)
        
    }
    
    func test_removePotentialInvite(){
        let newUser = User(firstName: "testfirstName",
                           lastName: "testlastName",
                           email:"testemail",
                           username:  "testusername",
                           profilePicURL: nil ,
                           passwordHash: "1",
                           key: "testinguserId"
        )
        self.testViewModel.addPotentialInvite(user: newUser)
        XCTAssertEqual(self.testViewModel.toBeInvited.count, 1)
        self.testViewModel.removePotentialInvite(user: newUser)
        XCTAssertEqual(self.testViewModel.toBeInvited.count, 0)
        
    }
    func test_clearToBeInvited(){
        let newUser1 = User(firstName: "testfirstName",
                            lastName: "testlastName",
                            email:"testemail",
                            username:  "testusername",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "testinguserId1"
        )
        let newUser2 = User(firstName: "testfirstName",
                            lastName: "testlastName",
                            email:"testemail",
                            username:  "testusername",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "testinguserId2"
        )
        self.testViewModel.addPotentialInvite(user: newUser1)
        self.testViewModel.addPotentialInvite(user: newUser2)
        XCTAssertEqual(self.testViewModel.toBeInvited.count, 2)
        self.testViewModel.clearToBeInvited()
        XCTAssertEqual(self.testViewModel.toBeInvited.count, 0)
        
    }
    
    func test_indexGuestEvents(){
        
        XCTAssertEqual(self.testViewModel.login(username: "john", pword: "123"), true)
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let res = self.testViewModel.indexGuestEvents()
        XCTAssertEqual(res.first?.key, "testeventId1")
        XCTAssertEqual(res.last?.key, "testeventId2")
        //}
    }
    
    func test_indexHostEvents(){
        let curTime1 = Date() + (25 * 60)
        let curTime2 = Date() + (35 * 60)
        let curTime3 = Date() - (25 * 60)
        let curTime4 = Date() - (15 * 60)
        let newEvent3 = Event(name: "event3", startTime: curTime1 , endTime: curTime2, street1: "teststreet1", street2: "teststreet2", city: "testcity", state: "pa", zip: "12345", description: "testdescription", key: "testeventIda",attendenceVisible:true,friendsAttendingVisible:false)
        let newEvent4 = Event(name: "event4", startTime: curTime3 , endTime: curTime4, street1: "teststreet1", street2: "teststreet2", city: "testcity", state: "pa", zip: "12345", description: "testdescription", key: "testeventIdb",attendenceVisible:true,friendsAttendingVisible:false)
        self.testViewModel.events.append(newEvent3)
        self.testViewModel.currentEvents.append(newEvent4)
        let newHost5 = Host(userKey: "John" ,
                            eventKey:"testeventIda",
                            key : "testhostId5")
        let newHost6 = Host(userKey: "John" ,
                            eventKey:"testeventIdb",
                            key : "testhostId6")
        self.testViewModel.hosts.append(newHost5)
        self.testViewModel.hosts.append(newHost6)
        XCTAssertEqual(self.testViewModel.login(username: "john", pword: "123"), true)
        let _ = self.testViewModel.indexHostEvents()
        XCTAssertEqual(self.testViewModel.hostEvents.count,2)
        XCTAssertEqual(self.testViewModel.hostEvents.first?.name,"event1")
        XCTAssertEqual(self.testViewModel.hostEvents.last?.name,"event3")
        XCTAssertEqual(self.testViewModel.hostCurrentEvents.count,1)
        XCTAssertEqual(self.testViewModel.hostCurrentEvents.last?.name,"event2")
        XCTAssertEqual(self.testViewModel.hostPastEvents.count,1)
        XCTAssertEqual(self.testViewModel.hostPastEvents.last?.name,"event4")
        
        
    }
    
    
    func test_searchUser(){
        
        self.testViewModel.users.removeAll()
        let newUser1 = User(firstName: "ab",
                            lastName: "bc",
                            email:"testemail",
                            username:  "cd",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "testinguserId1"
        )
        let newUser2 = User(firstName: "bc",
                            lastName: "cd",
                            email:"testemail",
                            username:  "ef",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "testinguserId2"
        )
        let newUser3 = User(firstName: "cd",
                            lastName: "ef",
                            email:"testemail",
                            username:  "gh",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "testinguserId3"
        )
        self.testViewModel.users.append(newUser1)
        self.testViewModel.users.append(newUser2)
        self.testViewModel.users.append(newUser3)
        var res1 = self.testViewModel.searchUsers(query: "ab", eventKey: "test")
        XCTAssertEqual(res1.count, 1)
        res1 = self.testViewModel.searchUsers(query: "bc", eventKey: "test")
        XCTAssertEqual(res1.count, 2)
        res1 = self.testViewModel.searchUsers(query: "cd", eventKey: "test")
        XCTAssertEqual(res1.count, 3)
        res1 = self.testViewModel.searchUsers(query: "ef", eventKey: "test")
        XCTAssertEqual(res1.count, 2)
        res1 = self.testViewModel.searchUsers(query: "gh", eventKey: "test")
        XCTAssertEqual(res1.count, 1)
        
    }
    
    func test_getNon_friends(){
        let newUser1 = User(firstName: "ab",
                            lastName: "bc",
                            email:"testemail",
                            username:  "cd",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "testuserKey1"
        )
        self.testViewModel.thisUser = newUser1
        let res = self.testViewModel.getNonFriends()
        XCTAssertEqual(res.count, 2)
        XCTAssertEqual(res.first?.key, "Dwight")
        XCTAssertEqual(res.last?.key, "Tom")
        
        
    }
    
    func test_getNotInvitedUsers(){
        let newUser1 = User(firstName: "ab",
                            lastName: "bc",
                            email:"testemail",
                            username:  "cd",
                            profilePicURL: nil ,
                            passwordHash: "1",
                            key: "testuserKey1"
        )
        self.testViewModel.thisUser = newUser1
        let res1 = self.testViewModel.getNotInvitedUsers(eventKey: "testeventId1")
        XCTAssertEqual(res1.count, 1)
        XCTAssertEqual(res1.last?.key, "Tom")
        let res2 = self.testViewModel.getNotInvitedUsers(eventKey: "testeventId2")
        XCTAssertEqual(res2.count, 2)
        XCTAssertEqual(res2.first?.key, "Dwight")
        XCTAssertEqual(res2.last?.key, "Jim")
        
    }
    
    func test_indexPendingGuestEvents(){
        XCTAssertEqual(self.testViewModel.login(username: "jim", pword: "1"), true)
        let res = self.testViewModel.indexPendingGuestEvents()
        XCTAssertEqual(res.count, 1)
        XCTAssertEqual(res.first?.key, "testeventId1")
        
    }
    
    func test_indexPendingEventGuests(){
        let res1 = self.testViewModel.indexPendingEventGuests(eventKey:"testeventId1")
        XCTAssertEqual(res1.count, 2)
        XCTAssertEqual(res1.first?.key, "Dwight")
        XCTAssertEqual(res1.last?.key, "Jim")
        let res2 = self.testViewModel.indexPendingEventGuests(eventKey:"testeventId2")
        XCTAssertEqual(res2.count, 1)
        XCTAssertEqual(res2.first?.key, "Tom")
        
    }
    
    
}
