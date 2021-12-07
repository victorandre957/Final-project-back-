class FavouriteSerializer < ActiveModel::Serializer
  attributes :product_id

  belongs_to :product

end
