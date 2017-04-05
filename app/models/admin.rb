class Admin < ActiveRecord::Base
  has_secure_password

  validates :username, uniqueness: true
end
