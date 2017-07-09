class Expense < ApplicationRecord
  belongs_to :user
  validates :amount, numericality:true
end
