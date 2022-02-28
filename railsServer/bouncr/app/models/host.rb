class Host < ApplicationRecord
  belongs_to :user
  belongs_to :event
  #Scope
  scope :by_user, -> (user_id){where('user_id = ?',user_id)}
end
