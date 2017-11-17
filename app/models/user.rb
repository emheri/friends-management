class User < ApplicationRecord

  # has_many
  #++
  has_many :friends
  has_many :friendships, through: :friends, source: "friend"
  has_many :subscribes
  has_many :subscriber, through: :subscribes, source: "subscriber"
  has_many :follows, class_name: "Subscribe", foreign_key: "subscriber_id"
  has_many :followings, through: :follows, source: "user"
  has_many :blocks
  has_many :blockers, through: :blocks, source: "blocked"
  has_many :blocked, class_name: "Block", foreign_key: "blocked_id"
  has_many :blocked_by, through: :blocked, source: "user"
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

  def send_feeder(text)
    receiver = []
    friendships.each { |f| receiver << f.email }
    subscriber.each { |s| receiver << s.email }
    scan_email(text).each { |m| receiver << m }
    blocked_by.each { |b| receiver.delete(b.email) }

    return receiver.uniq
  end
  #--
  
  private

  # private instance methods
  #++
  def scan_email(text)
    text.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
  end
  #--
  
end
