class Friend < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  #Scope
  scope :accepted, ->{where(accepted,true)}
  scope :by_user, -> (user_id){where('user1_id = ? OR user2_id = ?',user_id,user_id)}
  #Methods
  
end
