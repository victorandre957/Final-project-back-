class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :type_name

  def type_name 
    object.type.name
  end

end
