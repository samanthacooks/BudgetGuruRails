class Account < ApplicationRecord
  belongs_to :user
  validates :type, :balance, :bank_name, presence:true
end
