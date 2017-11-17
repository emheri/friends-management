require 'rails_helper'

RSpec.describe Subscribe, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:subscriber_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:subscriber_id).with_message("Already subscribe") }
end
