require 'rails_helper'

RSpec.describe Friend, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:friend_id) }
end
