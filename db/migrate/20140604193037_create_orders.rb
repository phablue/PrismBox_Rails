class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :order_id
      t.string :full_name
      t.string :email
      t.string :laptop_serial_number
      t.string :order_status

      t.timestamps
    end
  end
end
