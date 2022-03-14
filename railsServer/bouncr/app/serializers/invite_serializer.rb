class InviteSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :event
  belongs_to :user
  attributes :checkinTime , :inviteStatus, :checkinStatus , :coverChargePaid
end
