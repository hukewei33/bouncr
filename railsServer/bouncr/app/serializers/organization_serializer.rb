class OrganizationSerializer
  include FastJsonapi::ObjectSerializer
  #has_many :events , through: :organization_events
  attributes :name
end
