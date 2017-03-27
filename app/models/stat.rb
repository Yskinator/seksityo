class Stat < ActiveRecord::Base

  def initialize
    super
    self.created = 0
    self.alerts_sent = 0
    self.notifications_sent = 0
    self.confirmed = 0
  end

  def self.increment_created(country)
    stat = Stat.find_by_country_code(country)
    if stat
      stat.created += 1
      stat.save
    else
      stat = Stat.new
      stat.country_code = country
      stat.created += 1
    end
  end
end
