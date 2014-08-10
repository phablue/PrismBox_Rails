require 'spec_helper'

describe Laptop do
  def create_laptop laptop
    Laptop.create(serial_number: laptop[0], model_: laptop[1], hdd_size: laptop[2], cpu_speed: laptop[3], ram: laptop[4], screen_size: laptop[5], purchased_date: laptop[6])
  end

  describe "Laptop attributes must not be empty except state attribute" do
    before(:each) {
      @laptop = ["123456", "Air Mac", "10GB", "10GB", "10GB", "55", Date.new(2014,05,05)]
    }

    it "Validates when every attributes are not empty except state attribute" do
      expect(create_laptop(@laptop).valid?).to be_truthy
    end

    it "Invalidates when serial_number is empty" do
      @laptop[0] = nil
      expect(create_laptop(@laptop).valid?).not_to be_truthy
    end

    it "Invalidates when model_ is empty" do
      @laptop[1] = nil
      expect(create_laptop(@laptop).valid?).not_to be_truthy
    end

    it "Invalidates when hdd_size is empty" do
      @laptop[2] = nil
      expect(create_laptop(@laptop).valid?).not_to be_truthy
    end

    it "Invalidates when cpu_speed is empty" do
      @laptop[3] = nil
      expect(create_laptop(@laptop).valid?).not_to be_truthy
    end

    it "Invalidates when ram is empty" do
      @laptop[4] = nil
      expect(create_laptop(@laptop).valid?).not_to be_truthy
    end

    it "Invalidates when screen_size is empty" do
      @laptop[5] = nil
      expect(create_laptop(@laptop).valid?).not_to be_truthy
    end

    it "Invalidates when purchased_date is empty" do
      @laptop[6] = nil
      expect{create_laptop(@laptop)}.to raise_error
    end

    it "purchased_date must not be in the future" do
      @laptop[6] = Date.new(2050,12,10)
      expect(create_laptop(@laptop).valid?).not_to be_truthy
    end
  end

  describe "Chcek relationship with orders" do
    it { should have_many(:orders) }
  end
end
