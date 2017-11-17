class Subscribe < ApplicationRecord

  # belongs_to
  #++
  belongs_to :user
  belongs_to :subscriber, class_name: "User"
  #--

  # validations
  #++
  validates :user_id, presence: true
  validates :subscriber_id, presence: true
  validates_uniqueness_of :user_id, :scope => :subscriber_id, message: "Already subscribe"
  #--
end
