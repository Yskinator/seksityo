class Meeting < ActiveRecord::Base
  validates :duration, numericality: { greater_than: 0,
                                       only_integer: true,
                                       less_than: 1440 }, allow_blank: false

  validate :validate_phone_number

  def self.max_per_user_per_day
    20
  end

  def self.max_total_per_day
    1000
  end

  def time_to_live
    time = Time.new
    minutes = (((self.created_at + (self.duration * 60)) - time)/60)

    # Only round minutes if the value is higher than 1
    unless minutes.between?(0,1)
      minutes = minutes.round
    end

    if minutes < 0
      minutes = 0
    end

    return minutes
  end

  def create_hashkey
    self.hashkey = Digest::SHA2.new(512).hexdigest(self.nickname + self.phone_number + Time.now.to_s)
  end

  def send_notification(locale, session_hash)
    unless self.alert_sent?
      I18n.locale = locale
      ApplicationMailer.notification_email(self).deliver_now
      #Stat.increment_notifications_sent(self.get_country_code, self.get_country)
      create_impression(session_hash, "notification_sent")
    end
  end

  def send_alert(session_hash)
    unless self.message_sent
      self.update(alert_sent: true)
      create_impression(session_hash, "alert_sent")
      ApplicationMailer.alert_email(self).deliver_now
    end
  end

  def create_impression(session_hash, type, status="-")
    #We only want unique views. If the view already exists, update the country_code instead.
    if type=="view" && Impression.exists?(session:session_hash, impression_type:type)
      impression = Impression.where(session:session_hash, impression_type:type).first
      impression.country_code=self.get_country_code
      impression.save
      return
    end
    impression = Impression.new impression_type:type, session:session_hash, country_code:self.get_country_code, status:status
    unless self.latitude.nil?
      #Rounded a little for privacy's sake - that way we don't keep the exact location, only the general area
      impression.latitude = ((self.latitude.to_f*100.0).round / 100.0).to_s
      impression.longitude = ((self.longitude.to_f*100.0).round / 100.0).to_s
    end
    impression.save
  end

  def validate_phone_number
    phone = Phonelib.parse(self.phone_number)
    unless self.phone_number == '9991231234' or phone.valid?
      errors.add(:phone_number, "Phone number is invalid.")
    end
  end

  def parse_phone_number
    phone = Phonelib.parse(self.phone_number)
    self.phone_number = phone.sanitized
  end

  def delete_job()
    job = find_job()
    if job
      job.delete
    end
  end

  def find_job()
    jobs = Delayed::Job.all
    found_job = nil
    jobs.each do |job|
      meeting = YAML::load(job.handler)
      if meeting.hashkey.match(hashkey)
        found_job = job
      end
    end
    found_job
  end

  def get_country_code()
    phone = Phonelib.parse(self.phone_number)
    return phone.country_code
  end

  def get_country()
    phone = Phonelib.parse(self.phone_number)
    return phone.country
  end

  def message_sent()
    return (self.alert_sent? or self.time_to_live==0)
  end

  def self.has_exceeded_max_total()
    alerts = Impression.where(:impression_type => 'alert_sent', :created_at => (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)).count
    notifications = Impression.where(:impression_type => 'notification_sent', :created_at => (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)).count
    total_messages = alerts + notifications
    return (total_messages >= Meeting.max_total_per_day)
  end

  def self.clear_obsolete()
    meetings = Meeting.all
    for meeting in meetings do
      if meeting.message_sent()
        meeting.destroy()
      end
    end
  end
end
