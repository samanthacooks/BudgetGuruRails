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
    bill_name:params["user"]["bill_name"],
    amount: params["user"]["amount"],
    due_date: params["user"]["due_date"],
    status: params["user"]["status"],
    user_id: 7
    )
    if @bill.save
      render json: @bill, status: 200
    else
      render json: @bill.errors, status: 422
    end
  end

  def update
  end

  def destroy
    bill = Bill.find_by(id:params[:id]).destroy
    render json: bill
  end

  private

  def bill_params
    params.require(:bill).permit(:bill_name,:amount,:due_date,:status,:user_id)
  end
end
