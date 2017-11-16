class Friend < ApplicationRecord

  # belongs_to
  #++
  belongs_to :user
  belongs_to :friend, class_name: "User"
  #--

  # validations
  #++
  validates :user_id, presence: true
  validates :friend_id, presence: true
  #--

  # public class methods
  #++
  def self.find_connection(user_id, friend_id)
    self.where("user_id = ? AND friend_id = ?", user_id, friend_id)
  end
  #--
  
end
