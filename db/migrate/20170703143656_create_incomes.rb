class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.string :source, null:false
      t.integer :post_tax_amount, null:false
      t.boolean :fixed, null:false, default:true
      t.string :pay_schedule
      t.integer :user_id, foreign_key:true, null:false

      t.timestamps
    end
  end
end
