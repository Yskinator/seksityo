# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
meetings = 20
statistics = 10

User.create(username: "admin", password: "admin", password_confirmation: "admin")

(1..meetings).each do |i|
  Meeting.create(nickname: "test_#{i}", duration: rand(1..1440), phone_number: "9991231234", alert_sent: [true, false].sample, created_at: Time.at(rand(Time.new(2010).to_f..Time.new().to_f)) )
end

(1..statistics).each do |i|
  Stat.create(country_code: (i*100).to_s, created: rand(1..3000), confirmed: rand(1..2000), alerts_sent: rand(1..500), notifications_sent: rand(1..3000) )
end
