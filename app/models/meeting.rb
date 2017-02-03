class Meeting < ActiveRecord::Base
  validates :duration, numericality: { greater_than: 0,
                                       only_integer: true,
                                       less_than: 1440 }, allow_blank: true

  validates :phone_number, phone: true

  def time_to_live
    time = Time.new
    minutes = (((self.created_at + (self.duration * 60)) - time)/60).round

    return minutes
  end


end
