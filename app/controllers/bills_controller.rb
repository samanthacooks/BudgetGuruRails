class BillsController < ApplicationController
  def allbills
    bills = Bill.where(user_id:7)
    render json:bills
  end

  def recent
    bills = Bill.where(user_id:7).order(:due_date).limit(10)
    render json:bills
  end

  def create
    # binding.pry
    @bill = Bill.new(
    bill_name:params["bill_name"],
    amount: params["amount"],
    due_date: params["due_date"],
    status: params["status"],
    user_id: 1
    )
    if @bill.save
      render json: @bill, status: 200
    else
      render json: @bill.errors, status: 422
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:bill_name,:amount,:due_date,:status,:user_id)
  end
end
