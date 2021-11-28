class Type < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

end
