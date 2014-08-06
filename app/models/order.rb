class Order < ActiveRecord::Base
  validates :full_name, :email, :laptop_serial_number, presence: true
  belongs_to :user
  belongs_to :laptop
end
