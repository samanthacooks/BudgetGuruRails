class IncomesController < ApplicationController
  def index
    incomes = Income.where(user_id:1)
    render json:incomes
  end

  def create
    # binding.pry
    income = Income.new(
    source:params["user"]["source"],
    post_tax_amount: params["user"]["post_tax_amount"],
    fixed: params["user"]["fixed"],
    pay_schedule: params["user"]["pay_schedule"],
    user_id: 1
    )
    if income.save
      render json: income, status: 200
    else
      render json: income.errors, status: 422
    end
  end

  def update
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
