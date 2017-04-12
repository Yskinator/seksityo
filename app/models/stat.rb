class Stat < ActiveRecord::Base

  def initialize
    super
    self.created = 0
    self.alerts_sent = 0
    self.notifications_sent = 0
    self.confirmed = 0
  end

  def self.increment_created(country_code, country)
    find_stat(country_code, country)
    @stat.increment!(:created)
  end

  def self.increment_notifications_sent(country_code, country)
    find_stat(country_code, country)
    @stat.increment!(:notifications_sent)
  end

  def self.increment_alerts_sent(country_code, country)
    find_stat(country_code, country)
    @stat.increment!(:alerts_sent)
  end

  def self.increment_confirmed(country_code, country)
    find_stat(country_code, country)
    @stat.increment!(:confirmed)
  end

  def self.find_stat(country_code, country)
    @stat = Stat.find_by_country_code(country_code)
    if @stat
      return
    else
      @stat = Stat.new
      @stat.country_code = country_code
      @stat.country = country
      @stat.save
    end
  end

end
