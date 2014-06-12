class Order < ActiveRecord::Base
  validates :name, :email, :laptop_number, presence: true
  belongs_to :laptop
  belongs_to :user
end
