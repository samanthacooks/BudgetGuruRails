class CreateBills < ActiveRecord::Migration[5.1]
  def change
      create_table :bills do |t|
        t.string :bill_name, null:false
        t.string :status, null:false
        t.boolean :recurring, null:false, default: true
        t.integer :amount, null:false
        t.integer :due_date, null:false
        t.integer :user_id, foreign_key:true, null:false

        t.timestamps
      end
  end
end
