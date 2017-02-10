class ApplicationMailer < ActionMailer::Base
  default from: "seksityo@gmail.com"

  def hello_email
    mail(to: "tyoseksi@gmail.com", subject: 'Hello World')
  end
end
