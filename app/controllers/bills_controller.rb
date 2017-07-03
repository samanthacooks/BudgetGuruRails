class BillsController < ApplicationController
  def allbills
    bills = Bill.where(user_id:7)
    render json:bills
  end

  def recent
    bills = Bill.where(user_id:7).order(:due_date).limit(10)
    render json:bills
  end
end
