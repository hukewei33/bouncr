class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username , :email, :firstName , :lastName , :phoneNumber
end
