require 'rails_helper'

RSpec.describe Block, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:blocked_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:blocked_id).with_message("Already blocked") }
end
