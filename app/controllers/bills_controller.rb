class BillsController < ApplicationController

  def convert_number_to_date(due_date)
    today = Date.today
    bill_due_date = nil

    if today.day > due_date
        #this will convert the(hypothetically speaking) day number (15) to "2017-07-15"
        bill_due_date = (today -(today.day-due_date))
      elsif today.day < due_date
        bill_due_date = (today +(due_date-today.day))
    end
    bill_due_date
  end


#this method will only show the users bills that have not been paid. And bills that are within a week of the due_date
  def allbills
    today = Date.today
    bills = Bill.where(user_id:1, status: "not paid")
    upcoming_bills = []

    bills.each do |bill|
      if today > convert_number_to_date(bill.due_date)
        bill.update_attribute(:status, "past due")
        upcoming_bills << bill
      end
      if today < convert_number_to_date(bill.due_date) && bill.due_date - today.day <= 7
        upcoming_bills << bill
      end
    end
    render json: upcoming_bills
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
    bill = Bill.find_by(id:params[:id]).update_attributes(
      bill_name:params[:bill_name],
      amount: params[:amount].to_i,
      due_date: params[:due_date].to_date.day,
      status: params[:status],
      user_id: 1
    )
      render json: bill, status: 200
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
