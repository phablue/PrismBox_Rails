require 'spec_helper'

describe Laptop do
  describe "Check validate presence" do
    it { should validate_presence_of :serial_number }
    it { should validate_presence_of :model_ }
    it { should validate_presence_of :hdd_size }
    it { should validate_presence_of :cpu_speed }
    it { should validate_presence_of :ram }
    it { should validate_presence_of :screen_size }
    it { should validate_presence_of :purchased_date }
  end
end
