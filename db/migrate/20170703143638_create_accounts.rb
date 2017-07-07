class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :type, null:false
      t.integer :balance, null:false
      t.string :bank_name, null:false
      t.integer :user_id, foreign_key:true, null:false

      t.timestamps
    end
  end
end
