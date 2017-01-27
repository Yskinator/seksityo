require 'rails_helper'

RSpec.describe Meeting, type: :model do
  it "has attributes set correctly" do
    meeting = Meeting.new nickname:"Pekka", phone_number:"0401231234", duration:30, confirmed: true

    expect(meeting.nickname).to eq("Pekka")
    expect(meeting.phone_number).to eq("0401231234")
    expect(meeting.duration).to eq(30)
    expect(meeting.confirmed).to eq(true)
  end

end
