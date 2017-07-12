class IncomesController < ApplicationController
  def index
    user = User.find_by(access_token:params[:token])
    incomes = user.incomes
    render json:incomes
  end

  def create
    user = User.find_by(access_token:params[:token])
    income = user.incomes.new(
      source:params["source"],
      post_tax_amount: params["post_tax_amount"],
      fixed: params["fixed"],
      pay_schedule: params["pay_schedule"]
    )
    if income.save
      render json: income, status: 200
    else
      render json: income.errors, status: 422
    end
  end

  def update
    user = User.find_by(access_token:params[:token])
    income = user.incomes.find_by(id:params[:id]).update_attributes(
      source: params[:source],
      post_tax_amount: params[:post_tax_amount],
      fixed: params[:fixed],
      pay_schedule: params[:pay_schedule]
    )
    render json: income, status: 200
  end

  def destroy
    income = Income.find_by(id:params[:id]).destroy
    render json: income
  end

  private

  def income_params
    params.require(:bill).permit(:source,:post_tax_amount,:fixed,:pay_schedule,:user_id)
  end
end
