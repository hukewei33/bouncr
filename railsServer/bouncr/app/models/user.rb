class User < ApplicationRecord
    has_secure_password

    has_many :hosts, dependent: :destroy
    has_many :invites, dependent: :destroy
    has_many :events, through: :hosts
    has_many :events, through: :invites

    has_many :initiatedFriendship, class_name: 'Friend', foreign_key: 'user1_id'
    has_many :recievedFriendship, class_name: 'Friend', foreign_key: 'user2_id'
end
