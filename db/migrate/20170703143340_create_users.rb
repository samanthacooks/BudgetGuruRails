class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null:false
      t.string :last_name, null:false
      t.string :email, null:false
      t.string :password_digest, null:false
      t.integer :balance_floor, null:false
      t.integer :remaining_balance

      t.timestamps
    end
  end
end
