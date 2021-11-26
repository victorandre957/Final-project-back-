class Product < ApplicationRecord
  belongs_to :type

  validates :name, :price, :quantity, :description, presence: true
  validates :price, :quantity, numericality: { greather_than_or_equal_to: 0 }

  has_many :favourites, dependent: :destroy
  has_one_attached :photo
end
