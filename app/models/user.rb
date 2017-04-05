class User < ActiveRecord::Base
  def create_code
    self.code = SecureRandom.hex
  end
end
