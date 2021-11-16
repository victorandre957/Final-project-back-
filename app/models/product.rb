class Product < ApplicationRecord
  belongs_to :type
  has_many :favourites, dependent: :destroy
end
