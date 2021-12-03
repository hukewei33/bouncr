//
//  ViewModel.swift
//  team10app
//
//  Created by Sara Song on 10/28/21.
//

import Foundation
import Combine
import Firebase
import SwiftUI

class ViewModel: ObservableObject {
    
    let userInterface: UserInterface
    let eventInterface: EventInterface
    let hostInterface: HostInterface
    let inviteInterface: InviteInterface
    let friendInterface: FriendInterface
    
    let hostsReference = Database.database().reference(withPath: "hosts")
    let eventsReference = Database.database().reference(withPath: "events")
    let usersReference = Database.database().reference(withPath: "users")
    let invitesReference = Database.database().reference(withPath: "invites")
    let friendReference = Database.database().reference(withPath: "friends")
    
    //  let appDelegate: AppDelegate = AppDelegate()
    
    @Published var hosts: [Host] = [Host]()
    @Published var events: [Event] = [Event]()
    @Published var pastEvents: [Event] = [Event]()
    @Published var currentEvents: [Event] = [Event]()
    @Published var users: [User] = [User]()
    @Published var invites: [Invite] = [Invite]()
    @Published var pendingInvites: [Invite] = [Invite]()
    @Published var friends: [Friend] = [Friend]()
    @Published var pendingFriends: [Friend] = [Friend]()
  
    //Separate variables for events on host index page
    @Published var hostEvents: [Event] = [Event]() //Upcoming events that just look like normal events on your Host index pg
    @Published var hostPastEvents: [Event] = [Event]() //Past events don't show up on Host index pg
    @Published var hostCurrentEvents: [Event] = [Event]() //Current events = ongoing events you can scan tickets for
    
    
    //For use in the inviteGuestsModal; build a list of users to send an invite to an event
    @Published var toBeInvited: [User] = [User]()
    
    @Published var searchResults: [User] = [User]()
    
    @Published var thisUser: User? = nil
    
    init() {
        //lets keep the interfaces for CUD so we dont blow up this file :)
        
        userInterface = UserInterface()
        eventInterface = EventInterface()
        hostInterface = HostInterface()
        inviteInterface = InviteInterface()
        friendInterface = FriendInterface()
      
        
        getHosts(){a in return }
        getEvents(){(a,b,c) in return }
        getUsers(){a in return }
        getInvites(){(a,b) in return }
    }
  
  func getHosts(completionHandler: @escaping ([Host]) -> Void) {
          hostsReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
              self.hosts.removeAll()
              for child in snapshot.children {
                  if let snapshot = child as? DataSnapshot,
                     let host = Host(snapshot: snapshot) {
                      self.hosts.append(host)
                  }
              }
              completionHandler(self.hosts)
          })
      }

      func getEvents(completionHandler: @escaping ([Event],[Event],[Event]) -> Void) {
          self.eventsReference.queryOrdered(byChild: "endTime").observe(.value, with: { snapshot in
              let curTime = Date().timeIntervalSinceReferenceDate
              self.events.removeAll()
              self.pastEvents.removeAll()
              self.currentEvents.removeAll()
              for child in snapshot.children {
                  if let snapshot = child as? DataSnapshot,
                     let event = Event(snapshot: snapshot) {
                      //past event
                      if event.endTime < curTime {self.pastEvents.append(event)}
                      //future event
                      else if event.startTime > curTime {self.events.append(event)}
                      //ongoing event
                      else {self.currentEvents.append(event)}
                  }
              }
              self.pastEvents = self.pastEvents.sorted { $0.startTime < $1.startTime }
              self.currentEvents = self.currentEvents.sorted { $0.startTime < $1.startTime }
//              print("currentevents")
//              print(self.events)
              self.events = self.events.sorted { $0.startTime < $1.startTime }
              print("events")
              print(self.events)
              self.indexHostEvents() // added for EventForm
              completionHandler(self.pastEvents,self.currentEvents,self.events)
          })
      }


      func getUsers(completionHandler: @escaping ([User]) -> Void){
          self.usersReference.queryOrdered(byChild: "firstName").observe(.value, with: { snapshot in
              self.users.removeAll()
              for child in snapshot.children {
                  if let snapshot = child as? DataSnapshot,
                     let user = User(snapshot: snapshot) {
                      self.users.append(user)
                  }
              }
              self.users = self.users .sorted { $0.username < $1.username }
              completionHandler(self.users)
          })
      }

      func getInvites(completionHandler: @escaping ([Invite],[Invite]) -> Void){
          self.invitesReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
              self.invites.removeAll()
              self.pendingInvites.removeAll()
              for child in snapshot.children {
                  if let snapshot = child as? DataSnapshot,
                     let invite = Invite(snapshot: snapshot) {
                    
                    // verify that a past event is not added to the pending invites or the invites
                    if self.pastEvents.filter{$0.key == invite.eventKey} == []{
                      
                      if invite.inviteStatus{
                          self.invites.append(invite)
                      }
                      else{
                          self.pendingInvites.append(invite)
                      }
                      
                    }

                      
                  }
              }
              completionHandler(self.invites,self.pendingInvites)

          })
      }

      func getFriends(completionHandler: @escaping ([Friend],[Friend]) -> Void){
          self.friendReference.queryOrdered(byChild: "userKey1").observe(.value, with: { snapshot in
            self.friends.removeAll()
            self.pendingFriends.removeAll()
              for child in snapshot.children {
                  if let snapshot = child as? DataSnapshot,
                     let friend = Friend(snapshot: snapshot) {
                      //if friend.userKey1 == userKey{
                          if friend.accepted{
                              self.friends.append(friend)
                          }
                          else{
                              self.pendingFriends.append(friend)
                          }

                      //}
                  }
              }
              completionHandler(self.friends,self.pendingFriends)
          })
      }

    
    func login(username: String, pword: String) -> Bool {
        for user in self.users {
            if (user.username == username && user.passwordHash == pword) {
                self.thisUser = user
                getFriends(){(friends,pendingFriends) in self.friends = friends.filter{$0.userKey1 == user.key}; self.pendingFriends = pendingFriends.filter{$0.userKey1 == user.key}}
                print("login successful")
                print(self.thisUser)
                return true // login was successful
            }
        }
        print("login failure")
        return false // login failed
    }
    
    func logout() {
        self.thisUser = nil;
    }
    
    func loggedin()->String?{
        print("loggedin")
        print(self.thisUser)
        if let user = self.thisUser {
            return user.key
        }
        return nil
    }
    
    func indexEventGuests(eventKey: String) -> [User] {
        let guestIDList = self.invites.filter {$0.eventKey == eventKey}.map{$0.userKey}
        return self.users.filter {guestIDList.contains($0.key)}
    }
  
    func indexPendingEventGuests(eventKey: String) -> [User] {
        let pendingGuestIDList = self.pendingInvites.filter {$0.eventKey == eventKey}.map{$0.userKey}
        return self.users.filter {pendingGuestIDList.contains($0.key)}
    }
  
    
    //return an array where the first number is the first number is the number of current attendess and the second number is the size of the guest list
    func getEventAttendence(eventKey: String) -> [Int]{
        print(eventKey)
        var eventInvites = self.invites.filter {$0.eventKey == eventKey}
        eventInvites += self.pendingInvites.filter{$0.eventKey == eventKey}
        print(eventInvites)
        return [eventInvites.filter {$0.checkinStatus}.count,eventInvites.count]
    }
    
    func getAttendingFriends(eventKey: String)->[User]{
        let friendIDs = self.friends.map {$0.userKey2}
        
        var result = indexEventGuests(eventKey: eventKey).filter {friendIDs.contains($0.key)}
        result.sort {
            if $0.lastName != $1.lastName { // first, compare by last names
                return $0.lastName < $1.lastName
            }
            else { // All other fields are tied, break ties by first name
                return $0.firstName < $1.firstName
            }
        }
        return result
    }
    
  //Get a list of all the hosts hosting an event (should prob just be one host)
    func indexEventHosts(eventKey:String) -> [User] {
        print(eventKey)
//      print(self.hosts)
        let hostIDList = self.hosts.filter {$0.eventKey == eventKey}.map{$0.userKey}
        print(hostIDList)
        print(self.users)
        print(self.users.filter {hostIDList.contains($0.key)})
        return self.users.filter {hostIDList.contains($0.key)}
    }
    
    //For use in the inviteGuestsModal; add someone to the potential list
    func addPotentialInvite(user: User) {
        self.toBeInvited.append(user)
    }
    
    //For use in the inviteGuestsModal; remove someone from the potential list
    func removePotentialInvite(user: User) {
        self.toBeInvited = self.toBeInvited.filter {$0.key != user.key}
    }
    
    //For use in the inviteGuestsModal; use the toBeInvited list to send invites to ppl
    func sendInvites(event: Event )-> [String]? {
        var inviteCreated:[String] = [String]()
        //need to make sure that the user is already not invited
        let currentGuests = indexEventGuests(eventKey: event.key).map {$0.key}
        for user in self.toBeInvited {
          //need to make sure that the user is already not invited
          if !(currentGuests.contains(user.key)) && user.key != thisUser?.key{
              if let newId = self.inviteInterface.create(userKey: user.key, eventKey: event.key){
                  inviteCreated.append(newId)
              }
              else{print("error in invite creation")}
          }
        }
        self.clearToBeInvited()
        return inviteCreated
    }
    
    func clearToBeInvited() {
        toBeInvited.removeAll()
    }
    
    func indexHostEvents() -> [Event] {
      print("indexHostEvents");
      let curTime = Date().timeIntervalSinceReferenceDate
        if let userKey = loggedin(){
            //Clear the 3 arrays
            self.hostEvents.removeAll()
            self.hostPastEvents.removeAll()
            self.hostCurrentEvents.removeAll()
            //Get list of all events this user is hosting
            let eventIDs: [String] = self.hosts.filter{$0.userKey == userKey }.map {$0.eventKey}
            var myEvents = self.events.filter {eventIDs.contains($0.key)}
            myEvents += self.currentEvents.filter  {eventIDs.contains($0.key)}
            myEvents += self.pastEvents.filter  {eventIDs.contains($0.key)}
            for event in myEvents {
              print(event.name)
                //past event
                if event.endTime < curTime {
                  self.hostPastEvents.append(event)
                  print("curTime: ", curTime)
                  print("event startTime: ", event.startTime)
                  print("event endTime: ", event.endTime)
                }
                //future event
                else if event.startTime > curTime {self.hostEvents.append(event)}
                //ongoing event
                else {self.hostCurrentEvents.append(event)}
            }
          
            //Sort the 3 arrays
            self.hostPastEvents = self.hostPastEvents.sorted { $0.startTime < $1.startTime }
            self.hostCurrentEvents = self.hostCurrentEvents.sorted { $0.startTime < $1.startTime }
            self.hostEvents = self.hostEvents.sorted { $0.startTime < $1.startTime }
            print("hostPastEvents: ", self.hostPastEvents)
            print("hostCurrentEvents: ", self.hostCurrentEvents)
            print("hostEvents: ", self.hostEvents)
            return myEvents
          }
          else {
            print("indexhostevents, not logged in")
            return []
          }
      }
  
//      func indexGuestEvents()->[Event]{
//        print("indexguestevents")
//        if let userkey = loggedin() {
//          print(userkey)
//          return []
//        }
//        else {
//          return []
//        }
//      }
    
    func indexGuestEvents()->[Event]{
      print("indexguestevents")
      if let userId = loggedin() {
        let eventIDs = self.invites.filter{$0.userKey == userId && $0.inviteStatus}.map {$0.eventKey}
          print("eventIDs")
          print(eventIDs)
          var myEvents = self.events.filter {eventIDs.contains($0.key)}
          print("myEvents")
          print(myEvents)
          myEvents += self.currentEvents.filter {eventIDs.contains($0.key)}
          //Users should be able to see ongoing events in their invitations too
          print("myEvents")
          print(myEvents)
          return myEvents
      }
      else{
          print("indexguestevents, not logged in")
          print(self.thisUser)
          return []
      }
    }
      
      func indexPendingGuestEvents()->[Event]{
        print("indexguestevents")
        if let userId = loggedin() {
          let eventIDs = self.invites.filter{$0.userKey == userId && !($0.inviteStatus)}.map {$0.eventKey}
            print("eventIDs")
            print(eventIDs)
            var myEvents = self.events.filter {eventIDs.contains($0.key)}
            print("myEvents")
            print(myEvents)
            myEvents += self.currentEvents.filter {eventIDs.contains($0.key)}
            //Users should be able to see ongoing events in their invitations too
            print("myEvents")
            print(myEvents)
            return myEvents
        }
        else{
            print("indexguestevents, not logged in")
            print(self.thisUser)
            return []
        }

    }
  
    func acceptInvite(invite: Invite){
      self.inviteInterface.update(key: invite.key, updateVals: ["inviteStatus": true])
      print("pendingInvites")
      print(pendingInvites)
      print("invites")
      print(invites)
    }
  
  func declineInvite(invite: Invite){
    self.inviteInterface.delete(key: invite.key)
    print("pendingInvites")
    print(pendingInvites)
    print("invites")
    print(invites)
  }
  
  
    // Get all the users who are not invited to an event, display in InviteGuestsModal
    func getNotInvitedUsers(eventKey: String) -> [User] {
      var guestIDList = self.invites.filter {$0.eventKey == eventKey}.map{$0.userKey}
      guestIDList += self.pendingInvites.filter {$0.eventKey == eventKey}.map{$0.userKey}
      return self.users.filter {!guestIDList.contains($0.key) && $0.key != self.thisUser!.key}
    }
    
    //creates an event and host relationship, returns key of host (intermediate table)
    func createEvent(name: String, startTime: Date, endTime: Date, street1: String, street2: String?, city : String, zip: String , state:String, description : String?,attendenceVisible:Bool, friendsAttendingVisible:Bool, testing:Bool = false)->(String,String)? {
        print("createEvent")
        if let newEventID = self.eventInterface.create(name: name, startTime: startTime, endTime:endTime, street1: street1, street2: street2, city: city, zip: zip, state: state, description: description,attendenceVisible:attendenceVisible, friendsAttendingVisible:friendsAttendingVisible),
           //we need a way to get login and store the user info of this user
           let userID = testing ? "testingID" : loggedin() {
               if let hostID = self.hostInterface.create(userKey: userID, eventKey: newEventID){
                   return (newEventID,hostID)
               }
        }
        else{
            print("failed to create new event hosting")
            return nil
        }
        return nil
    }
    
    func checkin(inviteKey:String)->Bool{
        print("checkin")
        print(self.thisUser)
        //use invitekey to get invite
        let thisInvite = self.invites.filter{$0.key == inviteKey}.map{$0.eventKey}
        //use eventid of invite to get hosts
        let hostIDs = self.hosts.filter{thisInvite.contains($0.eventKey)}.map{$0.userKey}
        //check the person scanning the id is one of the hosts
        if let scannerID = loggedin(),
           hostIDs.contains(scannerID){
            //update
            self.inviteInterface.update(key: inviteKey, updateVals: ["checkinStatus" : true,"checkinTime": Date().timeIntervalSinceReferenceDate])
            return true
        }
        else {
            return false
        }
    }
    
    
    func cascadeEventDelete(eventKey:String) {
        let a = self.hosts
        let b = self.pendingInvites
        let relatedHostIDs = self.hosts.filter {$0.eventKey == eventKey} .map {$0.key }
        relatedHostIDs.forEach {x in self.hostInterface.delete(key: x)}
        let relatedInviteIDs = self.invites.filter {$0.eventKey == eventKey} .map {$0.key }
        relatedInviteIDs.forEach {x in self.inviteInterface.delete(key: x)}
        let relatedPendingInviteIDs = self.pendingInvites.filter {$0.eventKey == eventKey} .map {$0.key }
        relatedPendingInviteIDs.forEach {x in self.inviteInterface.delete(key: x)}
        self.eventInterface.delete(key: eventKey)
    }
    
                                                                      
    func addFriend(userKey1: String, userKey2 : String)->(String,String)? {
        if let friendRelation1 = self.friendInterface.create(userKey1: userKey1, userKey2: userKey2)
        {
            if let friendRelation2 = self.friendInterface.create(userKey1: userKey2, userKey2: userKey1){
                self.friendInterface.update(key: friendRelation1, updateVals: ["twinKey" : friendRelation2])
                self.friendInterface.update(key: friendRelation2, updateVals: ["twinKey" : friendRelation1])
//                // ADDED TO INDICATE WHO INITIATED FOR VIEW
//                self.friendInterface.update(key: friendRelation1, updateVals: ["accepted" : true])
                return (friendRelation1,friendRelation2)
            }
            //second entry not created so we delete the first and try again
            self.friendInterface.delete(key: friendRelation1)
            print("unable to create second relationship in twin, failed to create friend request")
        }
        else{
            print("unable to create first relationship in twin, failed to create friend request")
        }
        return nil
    }
    
                                                                      
    func acceptFriendInvite(acceptedInvite:Friend){
        self.friendInterface.update(key: acceptedInvite.key, updateVals: ["accepted" : true])
        self.friendInterface.update(key: acceptedInvite.twinKey, updateVals: ["accepted" : true])
        
    }
    
                                                                      
    //can be used to remove friend or turn down invite
    func rejectFriend(rejectedInvite:Friend){
        self.friendInterface.delete(key: rejectedInvite.twinKey)
        self.friendInterface.delete(key: rejectedInvite.key)
        
    }
  
    //Returns an array of all Users the current user isn't friends with or has sent a friend request to
    func getNonFriends() -> [User] {
      let allFriends = self.pendingFriends + self.friends
      let user2IDs = allFriends.map {$0.userKey2}
      return self.users.filter{!user2IDs.contains($0.key) && $0.key != self.thisUser!.key}
    }
  
  func editProfile(updateVals: [String : Any]) -> (){
    if let userkey = self.loggedin(){
      userInterface.update(key: userkey ,updateVals: updateVals)
    }
    
  }
  
                                                                      
    func searchUsers(query: String, eventKey: String) -> [User] {
        if query == "" {
            return []
        }
        //add additional logic to prevent adding yourself or guests already added?
        let first_name_matches: [User] = self.users.filter{$0.firstName.lowercased().contains(query.lowercased())}
        let last_name_matches:  [User] = self.users.filter{$0.lastName.lowercased().contains(query.lowercased())}
        let userName_matches:  [User] = self.users.filter{$0.username.lowercased().contains(query.lowercased())}
        var result = Array(Set(first_name_matches).union(Set(last_name_matches)).union(Set(userName_matches)))
        result.sort {
            if $0.lastName != $1.lastName { // first, compare by last names
                return $0.lastName < $1.lastName
            }
            else { // All other fields are tied, break ties by first name
                return $0.firstName < $1.firstName
            }
        }
      
        //Get users who are already invited to this event
        let guestIDList = self.invites.filter {$0.eventKey == eventKey}.map{$0.userKey}
        //Filter out users who are already invited to the event, don't include in search results
        result = result.filter {!guestIDList.contains($0.key)}

        //needs to be added back in after login is implemented
        //      if let usr = self.currentUser {
        //        return result.filter{$0.id != usr.id}
        //      }
      
        self.searchResults =  result
        return result
    }
    
}
