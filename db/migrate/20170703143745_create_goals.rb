class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :goal_name, null:false
      t.integer :amount_saved, null:false
      t.string :timeframe, null:false
      t.boolean :achieved, null:false, default:false
      t.integer :total, null:false
      t.integer :budget_id, foreign_key:true, null:false

      t.timestamps
    end
  end
end
