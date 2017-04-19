require 'rails_helper'

RSpec.describe User, type: :model do
  it "generates a long string as a code" do
    user = User.new
    expect(user.code.length).to eq(32)
  end
  it "creates a correct recovery link" do
    user = User.new
    code = user.create_code
    recovery_link = user.create_recovery_link("http://test.com")
    expect(recovery_link).to eq("http://test.com/users/id=" + code)
  end
end
