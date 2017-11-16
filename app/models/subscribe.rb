class Subscribe < ApplicationRecord

  # belongs_to
  #++
  belongs_to :user
  belongs_to :subscriber, class_name: "User"
  #--
end
