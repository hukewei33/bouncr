class Event < ApplicationRecord
    has_many :hosts, dependent: :destroy
    has_many :invites, dependent: :destroy
    has_many :users, through: :hosts
    has_many :users, through: :invites
end
