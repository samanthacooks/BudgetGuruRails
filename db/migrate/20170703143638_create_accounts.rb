class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :category, null:false
      t.integer :balance, null:false
      t.string :company_name, null:false
      t.integer :user_id, foreign_key:true, null:false

      t.timestamps
    end
  end
end
