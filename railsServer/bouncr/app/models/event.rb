class Event < ApplicationRecord
    has_many :hosts, dependent: :destroy
    has_many :invites, dependent: :destroy
    has_many :users, through: :hosts
    has_many :users, through: :invites

    #Scopes
    scope :alphabetical, -> { order('name') }
    scope :forHost, ->(host_id) {joins(:hosts).where('hosts.user_id = ?',host_id)}
    scope :forGuest, ->(guest_id) {joins(:hosts).where('guests.user_id = ?',guest_id)}
    scope :current, -> {where(["star_time <= ? AND end_time >= ?", t = DateTime.now, t]) }
    scope :past, -> {where("end_time < ?",  DateTime.now) }
    scope :future, -> {where("star_time > ?", DateTime.now) }
    #Methods

end
