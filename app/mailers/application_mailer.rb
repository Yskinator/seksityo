class ApplicationMailer < ActionMailer::Base
  default from: "artemisumbrella@gmail.com"

  def notification_email(meeting)
    @meeting = meeting
    mail(to: @meeting.phone_number, subject: 'Duration of meeting has passed.')
  end

  def alert_email(meeting)
    @meeting = meeting
    mail(to: @meeting.phone_number, subject: 'Alert, friend is in danger!')
  end
end
