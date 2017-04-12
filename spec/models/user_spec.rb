require 'rails_helper'

RSpec.describe User, type: :model do
  it "generates a long string as a code" do
    user = User.new
    expect(user.code.length).to eq(32)
  end
end
