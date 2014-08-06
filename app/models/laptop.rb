class Laptop < ActiveRecord::Base
  validates :serial_number, :model_, :hdd_size, :cpu_speed, :ram, :screen_size, :purchased_date, presence: true
  has_many :orders
  has_one :user
end
