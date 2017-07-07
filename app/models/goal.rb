class Goal < ApplicationRecord
  belongs_to :budget

  validates :goal_name, :amount_saved, :timeframe, :total, :budget_id, presence:true
  validates :amount_saved, numericality: true
end
