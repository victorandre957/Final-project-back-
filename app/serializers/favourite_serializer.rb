class FavouriteSerializer < ActiveModel::Serializer
  attributes :product_id

  belongs_to :product, embed: :id, serializer: ProductSerializer, include: true

end
