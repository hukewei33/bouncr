class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  #Scope
  scope :by_user, -> (user_id){where('user_id = ?',user_id)}
  scope :by_event, ->(event_id){where('event_id = ?',event_id)}
  scope :checkedIn, ->{where('checkinStatus = ?',true)}
end
