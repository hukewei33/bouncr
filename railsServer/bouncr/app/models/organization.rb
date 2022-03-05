class Organization < ApplicationRecord
    has_many :organization_events, dependent: :destroy
    has_many :events , through: :organization_events
end
