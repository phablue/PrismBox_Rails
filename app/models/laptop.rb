class Laptop < ActiveRecord::Base
  validates :serial_number, :model_, :hdd_size, :cpu_speed, :ram, :screen_size, :purchased_date, presence: true
  validate :purchased_date_in_the_future
  has_many :orders

  private
  def purchased_date_in_the_future
    if purchased_date > Date.today
      errors.add(:purchased_date, "can't be in the future")
    end
  end
end
