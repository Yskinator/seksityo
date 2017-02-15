class ApplicationMailerPreview < ActionMailer::Preview

  # Accessible from http://localhost:3000/rails/mailers/application_mailer/notification_email
  def notification_email
    ApplicationMailer.notification_email
  end

  def alert_email

  end
end
