class Bill < ApplicationRecord
  belongs_to :user
  validates :bill_name, :amount, :due_date, :status, presence:true
  validates :amount,:due_date, numericality: true

end
