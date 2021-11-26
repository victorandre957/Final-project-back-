class Product < ApplicationRecord
  belongs_to :type
  has_many :favourites, dependent: :destroy
  has_one_attached :photo
end
