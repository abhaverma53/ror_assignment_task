class Product < ApplicationRecord
  has_and_belongs_to_many :orders
  validates :name, presence: true, uniqueness: true

  paginates_per 5
end
