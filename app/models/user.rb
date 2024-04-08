class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_token_authenticatable

  belongs_to :customer, optional: true
  belongs_to :seller, optional: true
  has_many :platform_api_calls

  ROLES = %w[customer seller admin]

  ROLES.each do |role|
    define_method "#{role}" do
      role == role
    end
  end
end
