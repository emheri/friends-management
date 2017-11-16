class User < ApplicationRecord

  # has_many
  #++
  has_many :friends
  has_many :friendships, through: :friends, source: "friend"
  #--

  # validations
  #++
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  #--
  

   # public instance methods
  #++
  def friend_list
    friendships.map(&:email)
  end
  #--
  
end
