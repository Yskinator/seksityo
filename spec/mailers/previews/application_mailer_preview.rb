class ApplicationMailerPreview < ActionMailer::Preview

  # Accessible from http://localhost:3000/rails/mailers/application_mailer/notification_email
  def notification_email
    @meeting = Meeting.new(nickname: "Matti", phone_number: "testi@testi.fi", duration: 1)
    ApplicationMailer.notification_email(@meeting)
  end

  def alert_email
    @meeting = Meeting.new(nickname: "Matti", phone_number: "testi@testi.fi", duration: 1)
    ApplicationMailer.alert_email(@meeting)
  end
end
