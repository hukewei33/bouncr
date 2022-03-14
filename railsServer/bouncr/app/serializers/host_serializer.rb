class HostSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :event
  belongs_to :user
  attributes 
end
