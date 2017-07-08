class Account < ApplicationRecord
  belongs_to :user
  validates :account, :balance, :bank_name, presence:true
end
