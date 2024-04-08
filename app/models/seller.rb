class Seller < ApplicationRecord
  has_many :orders
  has_one :user
end
