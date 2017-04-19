# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
meetings = 20
statistics = 10

# Admin user template
Admin.create(username: "admin", password: "admin", password_confirmation: "admin")

# Create some meetings with randomised creation date
(1..meetings).each do |i|
  m = Meeting.create(nickname: "test_#{i}", duration: rand(1..1440), phone_number: "9991231234", alert_sent: [true, false].sample, created_at: Time.at(rand(Time.new(2010).to_f..Time.new().to_f)) )
  m.create_hashkey
  m.save
end

# Create some random statistics
(1..statistics).each do |i|
  n = Stat.new
  n.country_code = (i*100).to_s
  n.created = rand(1..3000)
  n.confirmed = rand(1..2000)
  n.alerts_sent = rand(1..1000)
  n.notifications_sent = rand(1..3000)
  n.country = "Testzikistan ##{i}"
  n.save
end

# Create some meetings that will have time to live > 0
(1..5).each do |i|
  m = Meeting.create(nickname: "test_#{i}", duration: rand(1..1440), phone_number: "9991231234", alert_sent: [true, false].sample )
  m.create_hashkey
  m.save
end
