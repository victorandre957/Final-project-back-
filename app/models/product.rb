class Product < ApplicationRecord
  belongs_to :type

  validates :name, :price, :quantity, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_many :favourites, dependent: :destroy
end
