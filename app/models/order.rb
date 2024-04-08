class Order < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :seller, optional: true
  has_and_belongs_to_many :products

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount]
  end

  scope :custom_filter, ->(param) { where(amount: param) }
end
