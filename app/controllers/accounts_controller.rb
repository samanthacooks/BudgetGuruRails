class AccountsController < ApplicationController

  def index
    user = User.find_by(access_token:params[:token])
    accounts = user.accounts
    render json:accounts
  end

  def create
    user = User.find_by(access_token:params[:token])

    account = user.accounts.new(
      account: params["account"],
      balance: params["balance"],
      bank_name: params["bank_name"]
    )

    if account.save
      render json: account, status: 200
    else
      render json: account.errors, status: 422
    end
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
