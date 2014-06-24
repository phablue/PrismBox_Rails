class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :department
      t.string :current_borrowed_laptop
      t.string :current_borrowed_date

      t.timestamps
    end
  end
end
