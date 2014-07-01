class Order < ActiveRecord::Base
  validates :full_name, :email, :laptop_serial_number, presence: true
end
