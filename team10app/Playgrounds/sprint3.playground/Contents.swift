import UIKit
import Firebase

var greeting = "Hello, playground"
FirebaseApp.configure()
Database.database().isPersistenceEnabled = true

struct User {
    
    let ref: DatabaseReference?
    let key: String
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let profilePicURL: String?
    let passwordHash: String
    
    
    init(firstName: String, lastName: String, email: String, username: String, profilePicURL : String, passwordHash: String = "", key: String = "") {
        self.ref = nil
        self.key = key
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.profilePicURL = profilePicURL
        self.passwordHash = passwordHash
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let email = value["email"] as? String,
            let username = value["username"] as? String,
            let passwordHash = value["passwordHash"] as? String
        
        else {
            print("bad read")
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.profilePicURL = value["profilePicURL"] as? String
        self.passwordHash = passwordHash
    }
    
    
    
    func toAnyObject() -> Any {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "username": username,
            "profilePicURL": profilePicURL,
            "passwordHash":passwordHash
        ]
    }
}

class UserController{
    let usersReference = Database.database().reference(withPath: "users")
    
    
    func create(){
        let newUser = User(firstName: "Tom",
                        lastName: "Tomson",
                        email:"example",
                        username:  "example",
                        profilePicURL: "example" ,
                        passwordHash: "example" )
        self.usersReference.child("Tom").setValue(newUser.toAnyObject())
        
        let newUser1 = User(firstName: "John",
                        lastName: "Johnson",
                        email:"example",
                        username:  "example",
                        profilePicURL: "example" ,
                        passwordHash: "example" )
        self.usersReference.child("John").setValue(newUser1.toAnyObject())
        let newUser2 = User(firstName: "Dick",
                        lastName: "Dickson",
                        email:"example",
                        username:  "example",
                        profilePicURL: "example" ,
                        passwordHash: "example" )
        self.usersReference.child("Dick").setValue(newUser2.toAnyObject())
        let newUser3 = User(firstName: "Sam",
                        lastName: "Samson",
                        email:"example",
                        username:  "example",
                        profilePicURL: "example" ,
                        passwordHash: "example" )
        self.usersReference.child("Sam").setValue(newUser3.toAnyObject())

        self.usersReference.child("ToDel").setValue(newUser3.toAnyObject())
        
    }
    
    var Users: [User] = []
    
    func read(){
        self.usersReference.queryOrdered(byChild: "firstName").observe(.value, with: { snapshot in
            var newUsers: [User] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let user = User(snapshot: snapshot) {
                    print(user.firstName)
                    newUsers.append(user)
                }
                
            }
            self.Users = newUsers
        })
    }
    
    func update(key:String, updateVals:[String : Any]){
        self.usersReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.usersReference.child(key).removeValue()
    }
    
    
}

let userController = UserController()
userController.create()
userController.update(key: "Sam",updateVals: ["firstName": "Samchanged"] )
userController.delete(key: "ToDel")
userController.read()

struct Event {

    let ref: DatabaseReference?
    let key: String
    let name: String
    //timetype? what is the best and most convenient type that can be used for swift firebase
    let startTime: String
    let endTime: String?
    let street1: String
    let street2: String?
    let city: String
    let state: String
    let zip: String
    let description: String?


    init(name: String, startTime: String, endTime: String = "", street1: String, street2 : String = "", city: String, state: String, zip: String, description: String = "", key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.street1 = street1
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
        self.description = description
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"]as? String,
            //timetype? what is the best and most convenient type that can be used for swift firebase
            let startTime = value["startTime"]as? String,
            let street1 = value["street1"]as? String,
            let city = value["city"]as? String,
            let state = value["state"]as? String,
            let zip = value["zip"]as? String
        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.startTime = startTime
        self.endTime = value["endTime"]as? String
        self.street1 = street1
        self.street2 = value["street2"]as? String
        self.city = city
        self.state = state
        self.zip = zip
        self.description = value["description"]as? String
    }



    func toAnyObject() -> Any {
        return [
            "name":name,
            "startTime":startTime,
            "endTime":endTime,
            "street1":street1,
            "street2":street2,
            "city":city,
            "state":state,
            "zip":zip,
            "description":description
        ]
    }
}

class EventController {
    //Event
    var Events: [Event] = []
    let eventsReference = Database.database().reference(withPath: "events")
    
    func create(){
        let newEvent = Event(name: "Tom's party",
                        startTime: "2030 8/20",
                        endTime:"2330 8/20",
                        street1:  "Tom's street",
                        
                        city: "Pittsburgh",
                        state:  "PA",
                        zip: "15123" ,
                        description: "Fire Party")

        self.eventsReference.child("TomParty").setValue(newEvent.toAnyObject())
        
        let newEvent1 = Event(name: "John's party",
                        startTime: "2030 8/28",
                        endTime:"2330 8/28",
                        street1:  "John's street",
                        street2: "#13-45",
                        city: "Pittsburgh",
                        state:  "PA",
                        zip: "15123" ,
                        description: "Lame Party")

        self.eventsReference.child("JohnParty").setValue(newEvent1.toAnyObject())
        self.eventsReference.child("ToDel").setValue(newEvent1.toAnyObject())

    }
    
    func read(){
        self.eventsReference.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
            var newEvents: [Event] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let event = Event(snapshot: snapshot) {
                    print(event.name)
                    self.Events.append(event)
                }
            }

        })
    }
    
//    func update(key:String = "" ){
//        self.eventsReference.child("JohnParty").updateChildValues(["name": "John's party changed"])
//    }
//
//    func delete(key:String = "" ){
//        self.eventsReference.child("toDel").removeValue()
//    }
    func update(key:String, updateVals:[String : Any]){
        self.eventsReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.eventsReference.child(key).removeValue()
    }
    
}


let eventController = EventController()
eventController.create()
eventController.update(key: "JohnParty",updateVals: ["name": "John's party changed"] )
eventController.delete(key: "ToDel")
eventController.read()




struct Invite {

    let ref: DatabaseReference?
    let key: String
    let userKey: String
    let eventKey: String
    let checkinTime: String?
    let inviteStatus: Bool
    var checkinStatus: Bool

    init(userKey: String,eventKey: String,checkinTime: String = "", inviteStatus: Bool, checkinStatus: Bool, key: String = "") {
        self.ref = nil
        self.key = key
        self.userKey = userKey
        self.eventKey = eventKey
        self.checkinTime = checkinTime
        self.inviteStatus = inviteStatus
        self.checkinStatus = checkinStatus
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let eventKey = value["eventKey"] as? String,
            let userKey = value["userKey"] as? String,
            let inviteStatus = value["inviteStatus"] as? Bool,
            let checkinStatus = value["checkinStatus"] as? Bool
        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.userKey = userKey
        self.eventKey = eventKey
        self.checkinTime = value["checkinTime"] as? String
        self.inviteStatus = inviteStatus
        self.checkinStatus = checkinStatus
    }

    func toAnyObject() -> Any {
        return [
            "userKey": userKey,
            "eventKey": eventKey,
            "checkinTime": checkinTime,
            "inviteStatus": inviteStatus,
            "checkinStatus": checkinStatus
        ]
    }
}

class InviteController{
    //Invites
    var Invites: [Invite] = []
    let invitesReference = Database.database().reference(withPath: "invites")
    
    func create(){
        //create
        let newInvite = Invite(userKey: "Sam",
                        eventKey:  "TomParty",
                        inviteStatus: true,
                        checkinStatus: false
                        )

        self.invitesReference.child("TomPartySam").setValue(newInvite.toAnyObject())
        
        let newInvite1 = Invite(userKey: "Dick",
                        eventKey:  "JohnParty",
                        inviteStatus: true,
                        checkinStatus: false
                        )

        self.invitesReference.child("JohnPartyDick").setValue(newInvite1.toAnyObject())
        
        let newInvite2 = Invite(userKey: "Dick",
                        eventKey:  "TomParty",
                        inviteStatus: true,
                        checkinStatus: false
                        )

        self.invitesReference.child("TomPartyDick").setValue(newInvite2.toAnyObject())
        self.invitesReference.child("ToDel").setValue(newInvite2.toAnyObject())
    }
    
    func read(){
        self.invitesReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
            var newInvites: [Invite] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let invite = Invite(snapshot: snapshot) {
                    newInvites.append(invite)
                    print(invite.userKey)
                }
            }
            self.Invites = newInvites
        })
    }
    
//    func update(key:String = "" ){
//        self.invitesReference.child("TomPartyDick").updateChildValues(["eventKey": "TomPartychanged"])
//    }
//
//    func delete(key:String = "" ){
//        self.invitesReference.child("ToDel").removeValue()
//    }
    func update(key:String, updateVals:[String : Any]){
        self.invitesReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.invitesReference.child(key).removeValue()
    }
  
}

let inviteController = InviteController()
inviteController.create()
inviteController.update(key: "TomPartyDick",updateVals: ["eventKey": "TomPartychanged"])
inviteController.delete(key: "ToDel")
inviteController.read()


struct Host {

    let ref: DatabaseReference?
    let key: String
    let userKey: String
    let eventKey: String


    init(userKey: String,eventKey: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.userKey = userKey
        self.eventKey = eventKey

    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let eventKey = value["eventKey"] as? String,
            let userKey = value["userKey"] as? String

        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.userKey = userKey
        self.eventKey = eventKey

    }

    func toAnyObject() -> Any {
        return [
            "userKey": userKey,
            "eventKey": eventKey,
        ]
    }
}

class HostController{
    var Hosts: [Host] = []
    let hostsReference = Database.database().reference(withPath: "hosts")
    
    func create(){
        //create
        let newHost = Host(userKey: "Tom" ,
                        eventKey:"TomParty"
                       )
        self.hostsReference.child("TomPartyTom").setValue(newHost.toAnyObject())
        
        let newHost1 = Host(userKey: "John" ,
                        eventKey: "JohnParty"
                       )
        self.hostsReference.child("JohnPartyJohn").setValue(newHost1.toAnyObject())
        self.hostsReference.child("ToDel").setValue(newHost1.toAnyObject())
    }
    
    func read (){
        //read
        self.hostsReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
            var newHosts: [Host] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let host = Host(snapshot: snapshot) {
                    newHosts.append(host)
                    print(host.userKey)
                }
            }
            self.Hosts = newHosts
        })
    }
    
    func update(key:String, updateVals:[String : Any]){
        self.hostsReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.hostsReference.child(key).removeValue()
    }
    
}
let hostController = HostController()


hostController.create()
hostController.update(key: "JohnPartyJohn",updateVals: ["userKey":"JohnChanged"] )
hostController.delete(key: "ToDel")
hostController.read()



struct Friend {

    let ref: DatabaseReference?
    let key: String
    let userKey1: String
    let userKey2: String
    var active: Bool


    init(userKey1: String,userKey2: String, active: Bool, key: String = "") {
        self.ref = nil
        self.key = key
        self.userKey1 = userKey1
        self.userKey2 = userKey2
        self.active = active

    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let userKey1 = value["userKey1"] as? String,
            let userKey2 = value["userKey2"] as? String,
            let active = value["active"] as? Bool

        else {
            return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.userKey1 = userKey1
        self.userKey2 = userKey2
        self.active = active

    }

    func toAnyObject() -> Any {
        return [
            "userKey1": userKey1,
            "userKey2": userKey2,
            "active": active
        ]
    }
}

class FriendController{
    //Friend
    var Friends: [Friend] = []
    let friendsReference = Database.database().reference(withPath: "friends")
    
    func create(){
        let newFriend = Friend(userKey1: "Sam",
                        userKey2:  "Dick",
                        active: true)


        self.friendsReference.child("SamDick").setValue(newFriend.toAnyObject())
        let newFriend1 = Friend(userKey1: "Dick",
                        userKey2:  "Sam",
                        active: true)


        self.friendsReference.child("DickSam").setValue(newFriend1.toAnyObject())
        let newFriend2 = Friend(userKey1: "Sam",
                        userKey2:  "John",
                        active: true)


        self.friendsReference.child("SamJohn").setValue(newFriend2.toAnyObject())
        let newFriend3 = Friend(userKey1: "John",
                        userKey2:  "Sam",
                        active: true)


        self.friendsReference.child("JohnSam").setValue(newFriend3.toAnyObject())
        self.friendsReference.child("ToDel").setValue(newFriend3.toAnyObject())
    }
    
    func read(){
        //read
        self.friendsReference.queryOrdered(byChild: "userKey1").observe(.value, with: { snapshot in
            var newFriends: [Friend] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let friend = Friend(snapshot: snapshot) {
                    newFriends.append(friend)
                    print(friend.userKey1)
                }
            }
            self.Friends = newFriends
        })
    }
    
    
    func update(key:String, updateVals:[String : Any]){
        self.friendsReference.child(key).updateChildValues(updateVals)
    }
    
    func delete(key:String ){
        self.friendsReference.child(key).removeValue()
    }
}




let friendController = FriendController()

friendController.create()
friendController.update(key: "JohnSam", updateVals: ["userKey1" : "JohnChanged"])
friendController.delete(key: "ToDel")
friendController.read()




