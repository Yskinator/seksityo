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
      stat.save
    end
  end

  def self.increment_notifications_sent(country)
    stat = Stat.find_by_country_code(country)
    if stat
      stat.notifications_sent += 1
      stat.save
    else
      stat = Stat.new
      stat.country_code = country
      stat.notifications_sent += 1
      stat.save
    end
  end

  def self.increment_alerts_sent(country)
    stat = Stat.find_by_country_code(country)
    if stat
      stat.alerts_sent += 1
      stat.save
    else
      stat = Stat.new
      stat.country_code = country
      stat.alerts_sent += 1
      stat.save
    end
  end

  def self.increment_confirmed(country)
    stat = Stat.find_by_country_code(country)
    if stat
      stat.confirmed += 1
      stat.save
    else
      stat = Stat.new
      stat.country_code = country
      stat.confirmed += 1
      stat.save
    end
  end

end
