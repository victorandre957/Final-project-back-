class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :authentication_token
  has_many :favourites
end
