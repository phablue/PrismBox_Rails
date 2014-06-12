class CreateLaptops < ActiveRecord::Migration
  def change
    create_table :laptops do |t|
      t.string :serial_number
      t.string :model_
      t.string :hdd_size
      t.string :cpu_speed
      t.string :ram
      t.string :screen_size
      t.date :purchased_date
      t.string :state

      t.timestamps
    end
  end
end
