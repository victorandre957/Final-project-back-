class FavouriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :product_id

  belongs_to :product

end
