class User < ApplicationRecord
    has_secure_password

    has_many :hosts, dependent: :destroy
    has_many :invites, dependent: :destroy
    has_many :events, through: :hosts
    has_many :events, through: :invites

    has_many :initiatedFriendship, class_name: 'Friend', foreign_key: 'user1_id', dependent: :destroy
    has_many :recievedFriendship, class_name: 'Friend', foreign_key: 'user2_id',dependent: :destroy

    #Scopes
    scope :alphabetical, -> { order('username') }
    scope :search, -> (term){where('username LIKE ?', term)}
    scope :for_hosting, ->(event_id) {joins(:hosts).where('hosts.event_id = ?',event_id)}
    scope :for_invited, ->(event_id) {joins(:invites).where('invites.event_id = ?',event_id)}

    #Methods

end
