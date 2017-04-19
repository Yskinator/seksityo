class User < ActiveRecord::Base
  validate :validate_phone_number

  def initialize(user_params = nil)
    super
    self.credits = 0
    self.parse_phone_number
    self.create_code
  end

  def create_code
    self.code = SecureRandom.hex
  end

  #Copy-paste code alert!
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

  def send_recovery_link(recovery_link)
    ApplicationMailer.recovery_link_email(self, recovery_link).deliver_now
  end
end
