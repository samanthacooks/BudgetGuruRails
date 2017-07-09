class Expense < ApplicationRecord
  belongs_to :user
  validates :expense, numericality:true
end
