require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value("foo@email.com").for(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should have_secure_password }
end
