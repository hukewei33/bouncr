class FriendSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :user1, record_type: :user
  belongs_to :user2,  record_type: :user
  attributes :user1, :user2, :accpeted
end
