class BudgetsController < ApplicationController
    $USER = "user"

    def budgets
      $USER = User.find_by(access_token: params[:token])
        if $USER.budgets.empty?
          array = 0
        end

      budgets = {
        array: array,
        status:$USER.positive,
        budgets:$USER.budgets
      }
      render json: budgets
    end


    def create
      binding.pry
      @budget = $USER.budgets.new(
        budget_name: params["budget_name"],
        monthly_spend: params["monthly_spend"]
      )
      if @budget.save
        render json: @budget, status: 200
      else
        render json: @budget.errors, status: 422
      end
    end

    def update
      budget = Budget.find_by(id:params[:id]).update_attributes(
        budget_name: params["budget_name"],
        monthly_spend: params["monthly_spend"],
        user_id: $USER.id
      )
        render json: budget, status: 200
    end

    def destroy
      binding.pry
      budget = Budget.find_by(id:params[:id])
      if budget.destroy
        render json: budget, status: 200
      else
        render json: budget, status: 422
      end
    end

end
