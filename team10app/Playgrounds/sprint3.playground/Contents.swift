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
            //let key = value["key"] as? String,
            let email = value["email"] as? String,
            //how do I let this be optinal, do I only attenpt to unwrap later, what happens if it is null?
            let username = value["username"] as? String,
            let passwordHash = value["passwordHash"] as? String
        
        else {
            print("bad read")
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = "1"
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
    var Users: [User] = []
    
    func create(){
        let newUser = User(firstName: "examplefirstname2",
                        lastName: "example",
                        email:"example",
                        username:  "example",
                        profilePicURL: "example" ,
                        passwordHash: "example" )
        usersReference.child("exampleName2").setValue(newUser.toAnyObject())
    }
    
    func read(){
        usersReference.queryOrdered(byChild: "firstName").observe(.value, with: { snapshot in
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
        self.Users
    }
    
    func update(){
        self.Users[0].ref?.updateChildValues([
            "firstName": "changed"
           ])
    }
    
    
}
let userController = UserController()
userController.create()
userController.read()
userController.Users




//create

//update
//
//read







////delete

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
            //let key = value["key"]as? String,
            let name = value["name"]as? String,
            //timetype? what is the best and most convenient type that can be used for swift firebase
            let startTime = value["startTime"]as? String,
            //let endTime = value["endTime"]as? String,
            let street1 = value["street1"]as? String,
            //let street2 = value["street2"]as? String,
            let city = value["city"]as? String,
            let state = value["state"]as? String,
            let zip = value["zip"]as? String
            //let description = value["description"]as? String
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

//Event
var Events: [Event] = []
let eventsReference = Database.database().reference(withPath: "events")

//create
let newEvent = Event(name: "example",
                startTime: "example",
                endTime:"example",
                street1:  "example",
                street2: "example" ,
                city: "example",
                state:  "example",
                zip: "example" ,
                description: "example")




eventsReference.child("example1").setValue(newEvent.toAnyObject())


//read
eventsReference.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
    var newEvents: [Event] = []
    for child in snapshot.children {
        if let snapshot = child as? DataSnapshot,
           let event = Event(snapshot: snapshot) {
            print(event.name)
            Events.append(event)
        }
    }

})
Events

//update
//Events[0].ref?.updateChildValues([
//    "name": "changed"
//    ])
//
////delete
//Events[0].ref?.removeValue()


print("fin")

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
            //let key = value["key"]as? String,
            let eventKey = value["eventKey"] as? String,
            let userKey = value["userKey"] as? String,
            //let checkinTime = value["checkinTime"] as? String,
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

//Invites
var Invites: [Invite] = []
let invitesReference = Database.database().reference(withPath: "invites")

//create
let newInvite = Invite(userKey: "example",
                eventKey:  "example",
                checkinTime:  "example",
                inviteStatus: true,
                checkinStatus: true
                )



invitesReference.child("inviteExample").setValue(newInvite.toAnyObject())


//read
invitesReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
    var newInvites: [Invite] = []
    for child in snapshot.children {
        if let snapshot = child as? DataSnapshot,
           let invite = Invite(snapshot: snapshot) {
            newInvites.append(invite)
            print(invite.userKey)
        }
    }
    Invites = newInvites
})

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

var Hosts: [Host] = []
let hostsReference = Database.database().reference(withPath: "hosts")

//create
let newHost = Host(userKey: "example",
                eventKey:  "example"
               )


hostsReference.child("exampleHost").setValue(newHost.toAnyObject())


//read
hostsReference.queryOrdered(byChild: "userKey").observe(.value, with: { snapshot in
    var newHosts: [Host] = []
    for child in snapshot.children {
        if let snapshot = child as? DataSnapshot,
           let host = Host(snapshot: snapshot) {
            newHosts.append(host)
            print(host.userKey)
        }
    }
    Hosts = newHosts
})

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

//Friend
var Friends: [Friend] = []
let friendsReference = Database.database().reference(withPath: "friends")

//create
let newFriend = Friend(userKey1: "example",
                userKey2:  "example",
                active: true)


friendsReference.child("exampleFriend").setValue(newFriend.toAnyObject())


//read
friendsReference.queryOrdered(byChild: "userKey1").observe(.value, with: { snapshot in
    var newFriends: [Friend] = []
    for child in snapshot.children {
        if let snapshot = child as? DataSnapshot,
           let friend = Friend(snapshot: snapshot) {
            newFriends.append(friend)
            print(friend.userKey1)
        }
    }
    Friends = newFriends
})
