class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :amount, null:false
      t.integer :user_id, null:false
      t.timestamps
    end
  end
end
