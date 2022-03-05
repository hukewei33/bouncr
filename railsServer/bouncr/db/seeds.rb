# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username:"testUser",password:"testPassword",email:"test@test.com",firstName:"tester",lastName:"macTester",phoneNumber:"12345678")
user1 = User.create(username:"testUser1",password:"testPassword",email:"test@test.com",firstName:"tester",lastName:"macTester",phoneNumber:"12345678")
user2 = User.create(username:"testUser2",password:"testPassword",email:"test@test.com",firstName:"tester",lastName:"macTester",phoneNumber:"12345678")
friend1 = Friend.create(user1_id:user.id, user2_id:user1.id,accpeted:true)
friend1 = Friend.create(user1_id:user2.id, user2_id:user.id,accpeted:false)
event1 = Event.create(name:"event1")
event2 = Event.create(name:"event2")
event3 = Event.create(name:"event3")
org1 = Organization.create(name:"org1")
org2 = Organization.create(name:"org2")
eventorg1 = OrganizationEvent.create(organization_id: org1.id, event_id:event1.id)
eventorg2 = OrganizationEvent.create(organization_id: org2.id, event_id:event1.id)

host1 = Host.create(user_id: user.id, event_id:event1.id)
host2 = Host.create(user_id: user.id, event_id:event2.id)
host2 = Host.create(user_id: user1.id, event_id:event1.id)
guest1 = Invite.create(user_id: user.id, event_id:event1.id)
guest2 = Invite.create(user_id: user.id, event_id:event3.id)
guest2 = Invite.create(user_id: user2.id, event_id:event1.id)