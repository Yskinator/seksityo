require 'rails_helper'

RSpec.describe Meeting, type: :model do
  it "has attributes set correctly" do
    meeting = Meeting.new nickname:"Pekka", phone_number:"0401231234", duration:30, confirmed: true

    expect(meeting.nickname).to eq("Pekka")
    expect(meeting.phone_number).to eq("0401231234")
    expect(meeting.duration).to eq(30)
    expect(meeting.confirmed).to eq(true)
  end
  it "has proper time_to_live" do
    meeting = Meeting.new created_at:Time.new, nickname:"Pekka", phone_number:"0401231234", duration:30, confirmed: true
    expect(meeting.time_to_live).to eq(30)

    meeting.created_at = Time.new-120

    expect(meeting.time_to_live).to eq(28)

  end

  it "can create hashkey" do
    meeting = Meeting.new nickname:"Pekka", phone_number:"0401231234", duration:30, confirmed: true

    expect(meeting.hashkey).to eq(nil)

    meeting.create_hashkey

    expect(meeting.hashkey).not_to eq(nil)

  end

end
