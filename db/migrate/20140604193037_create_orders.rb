class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :full_name
      t.string :email
      t.string :laptop_serial_number
      t.string :order_confirm

      t.timestamps
    end
  end
end
