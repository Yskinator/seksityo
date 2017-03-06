class Meeting < ActiveRecord::Base
  validates :duration, numericality: { greater_than: 0,
                                       only_integer: true,
                                       less_than: 1440 }, allow_blank: true

  # Currently using email instead of phone numbers, validations off
  validates :phone_number, phone: true
  # validates_format_of :phone_number, :with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def time_to_live
    time = Time.new
    minutes = (((self.created_at + (self.duration * 60)) - time)/60).round
    if minutes < 0
      return 0
    end

    return minutes
  end

  def create_hashkey

    self.hashkey = Digest::SHA2.new(512).hexdigest(self.nickname + self.phone_number + Time.now.to_s)

  end

  def send_notification
    ApplicationMailer.notification_email(self).deliver_now
  end

  def send_alert
    ApplicationMailer.alert_email(self).deliver_now
  end

end
