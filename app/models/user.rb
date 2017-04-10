class User < ActiveRecord::Base
  validate :validate_phone_number

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
end
