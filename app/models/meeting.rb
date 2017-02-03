class Meeting < ActiveRecord::Base
  validates :duration, numericality: { greater_than: 0,
                                       only_integer: true,
                                       less_than: 1440 }, allow_blank: true

  validates :phone_number, phone: true

  def time_to_live
    time = Time.new
    minutes = (((self.created_at + (self.duration * 60)) - time)/60).round

    if minutes < 0
      return 0
    end

    return minutes
  end

  def create_hashkey
    self.hashkey = Digest::SHA2.new(512).digest(self.nickname + self.phone_number)
  end



end
