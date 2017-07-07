class Income < ApplicationRecord
  belongs_to :user

  validates :source, :post_tax_amount,:pay_schedule, presence:true
  validates :post_tax_amount, numericality: true
end
