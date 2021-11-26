class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :type_name, :price, :quantity, :description, :photo_url

  def photo_url
    if object.photo.attached?
      rails_blob_path(object.photo, only_path: true)
    end
  end

  def type_name 
    object.type.name
  end

end
