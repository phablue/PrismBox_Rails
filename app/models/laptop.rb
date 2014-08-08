class Laptop < ActiveRecord::Base
  validates :serial_number, :model_, :hdd_size, :cpu_speed, :ram, :screen_size, :purchased_date, presence: true
  validate :purchased_date_in_the_future
  has_many :orders
  has_one :user


  def purchased_date_in_the_future
    if self.purchased_date > Date.today
      errors.add(:purchased_date, "can't be in the future")
    end
  end
end
