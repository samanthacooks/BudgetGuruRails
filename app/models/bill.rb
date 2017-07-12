class Bill < ApplicationRecord
  belongs_to :user
  validates :bill_name, :amount, :due_date, :status, presence:true
  validates :amount,:due_date, numericality: true
  validates :status, inclusion: { in: ["paid", "not paid", "past due", "due today"],
    message: "'%{value}' is not a valid status" },  case_sensitive: false

end
