class ApplicationMailer < ActionMailer::Base
  default from: "seksityo@gmail.com"

  def notification_email
    mail(to: "tyoseksi@gmail.com", subject: 'Hello World')
  end

  def alert_email

  end
end
