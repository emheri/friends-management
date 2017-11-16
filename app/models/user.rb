class User < ApplicationRecord

  # has_many
  #++
  has_many :friends
  has_many :friendships, through: :friends, source: "friend"
  has_many :subscribes
  has_many :subscriber, through: :subscribes, source: "subscriber"
  has_many :follows, class_name: "Subscribe", foreign_key: "subscriber_id"
  has_many :followings, through: :follows, source: "user"
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
