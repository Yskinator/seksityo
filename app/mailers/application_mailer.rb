class ApplicationMailer < ActionMailer::Base
  default from: "artemisumbrella@gmail.com"

  def notification_email(meeting)
    @meeting = meeting
    mail(to: @meeting.phone_number+'@textmagic.com', subject: 'Duration of meeting has passed.')
  end

  def alert_email(meeting)
    @meeting = meeting
    mail(to: @meeting.phone_number+'@textmagic.com', subject: 'Alert, friend is in danger!')
  end
end
