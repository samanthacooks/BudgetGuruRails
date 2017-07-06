class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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
    @account = Account.new(category: params["category"], balance: params["balance"], company_name: params["company_name"], user_id: 1)
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
    params.require(:accounts).permit(:category,:balance,:company_name,:user_id)
  end
end
