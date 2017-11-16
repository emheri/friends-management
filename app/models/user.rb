class User < ApplicationRecord

  # has_many
  #++
  has_many :friends
  #--

  # validations
  #++
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  #--
  
end
