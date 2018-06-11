class Impression < ActiveRecord::Base
  def self.country_codes()
    return Impression.where(:impression_type => "alert_sent").or(Impression.where(:impression_type => "notification_sent")).uniq.pluck(:country_code)
  end
  def self.in_country_during_interval(country_code, interval_start, interval_end)
    return Impression.where(:country_code => country_code, :created_at => (interval_start..interval_end))
  end
  def self.message_sent()
    return Impression.where(:impression_type => "alert_sent").or(Impression.where(:impression_type => "notification_sent"))
  end
  def self.messages_sent_in_country_during_interval(country_code, interval_start, interval_end)
    return message_sent().merge(in_country_during_interval(country_code, interval_start, interval_end))
  end
  def self.statuses()
    return Impression.uniq.pluck(:status)
  end
  def self.location_percentage(country_code, interval_start, interval_end)
    total = messages_sent_in_country_during_interval(country_code, interval_start, interval_end)
    with_location = total.where.not(:latitude => nil)
    return with_location.count.to_f/total.count * 100
  end
  def self.status_percentages(country_code, interval_start, interval_end)
    messages = messages_sent_in_country_during_interval(country_code, interval_start, interval_end)
    total = messages.count
    percentages = {}
    for status in statuses() do
      percentages[status] = messages.where(:status => status).count.to_f / total * 100
    end
    return percentages
  end
  def self.generate_stats(interval_start, interval_end)
    stats = []
    for country_code in country_codes do
      stat = {}
      stat["country"] = country_code
      if interval_start.to_date == interval_end.to_date
        stat["date"] = interval_start.to_date
      else
        stat["date"] = interval_start.to_date.strftime("%m/%y")
      end
      impressions = in_country_during_interval(country_code, interval_start, interval_end)
      stat["views"] = impressions.where(:impression_type => "view").count
      stat["created"] = impressions.where(:impression_type => "meeting_created").count
      stat["confirmed"] = impressions.where(:impression_type => "meeting_ok").count
      stat["messages_sent"] = messages_sent_in_country_during_interval(country_code, interval_start, interval_end).count
      stat["alerts_sent"] = impressions.where(:impression_type => "alert_sent").count
      stat["notifications_sent"] = impressions.where(:impression_type => "notification_sent").count
      stat["location_percentage"] = location_percentage(country_code, interval_start, interval_end)
      stat.merge(status_percentages(country_code, interval_start, interval_end))
      stats.push(stat)
    end
    return stats
  end

end
