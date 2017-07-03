class BillsController < ApplicationController
  def index
    bills = Bill.where(user_id:7)
    render json:bills
  end
end
