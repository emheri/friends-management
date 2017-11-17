class Block < ApplicationRecord
  
  # belongs_to
  #++
  belongs_to :user
  belongs_to :blocked, class_name: "User"
  #--

  # validations
  #++
  validates :user_id, presence: true
  validates :blocked_id, presence: true
  validates_uniqueness_of :user_id, :scope => :blocked_id, message: "Already blocked"
  #--

  # public class methods
  #++
  def self.is_blocked?(first, second)
    blocked = where(["(user_id = :first AND blocked_id = :second) OR (user_id = :second AND blocked_id = :first)", 
      {first: first, second: second}])
    return blocked.present? ? true : false
  end
  #--
  
end
