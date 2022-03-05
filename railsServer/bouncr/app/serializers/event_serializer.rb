class EventSerializer
  include FastJsonapi::ObjectSerializer
  has_many :organizations, through: :organization_events
  attributes :name, :startTime , :endTime, :street1 , :street1, :street2, :city, :zip, :description, 
              :attendenceCap, :attendenceVisible , :friendsAttendingVisible , :coverCharge , :isOpenInvite , :venueLatitude, :venueLongitude
end
