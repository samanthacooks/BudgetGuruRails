class AccountsController < ApplicationController
  def index
    accounts = Account.where(user_id: 1)
    render json:accounts
  end

  def show
  end

  # def new
  #   @account = Account.new
  # end

  def create

    @account = Account.new(
    account: params["account"],
    balance: params["balance"],
    bank_name: params["bank_name"],
    user_id: 1
    )

    if @account.save
      render json: @account, status 200
    else
      render json: @account.errors, status 422
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def account_params
    params.require(:accounts).permit(:account,:balance,:bank_name,:user_id)
  end
end
