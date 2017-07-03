class CreateBudgets < ActiveRecord::Migration[5.1]
  def change
    create_table :budgets do |t|
      t.string :budget_name, null:false
      t.integer :monthly_spend, null:false
      t.boolean :goal, null:false, default:false
      t.integer :user_id, foreign_key:true, null:false

      t.timestamps
    end
  end
end
