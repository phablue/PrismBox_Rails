require 'spec_helper'

describe Order do
  it { should validate_presence_of :full_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :laptop_serial_number }
end
