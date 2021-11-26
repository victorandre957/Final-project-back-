class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :type_name, :price, :quantity, :description

  def type_name 
    object.type.name
  end

end
