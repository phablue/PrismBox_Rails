class Order < ActiveRecord::Base
  validates :name, :email, :laptop_number, presence: true
end
