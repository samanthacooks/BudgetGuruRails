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
    @bill = Bill.new(
    bill_name:params["bill"],
    amount: params["amount"],
    due_date: params["due_date"],
    status: params["status"],
    user_id: 1
    )
    if @bill.save
      flash[:success] = 'Bill was successfully created.'
    else
      flash[:error] = "Sorry, Could not create Bill"
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:bill_name,:amount,:due_date,:status,:user_id)
  end
end
