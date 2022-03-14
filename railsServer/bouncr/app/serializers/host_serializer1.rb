class HostSerializer1
  include FastJsonapi::ObjectSerializer
  belongs_to :user, :event

  attributes 
end
