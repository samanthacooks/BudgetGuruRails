class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null:false
      t.string :last_name, null:false
      t.string :email, null:false
      t.string :password_digest, null:false
      t.integer :balance_floor, null:false
      t.boolean :positive, null:false, default: false
      t.integer :remaining_balance, null:false, default: 0
      t.string :access_token
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
