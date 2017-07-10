class BudgetsController < ApplicationController
    def budgets
      budgets = {
        status:User.find_by(id:1).positive,
        budgets: Budget.where(user_id:1)
      }
      render json: budgets
    end

    def create
      @budget = Budget.new(
        budget_name: params["user"]["budget_name"],
        monthly_spend: params["user"]["monthly_spend"],
        goal: params["user"]["goal"],
        user_id: 1
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
        goal: params["goal"],
        user_id: 1
      )
        render json: budget, status: 200
    end

    def destroy
      budget = Budget.find_by(id:params[:id])
      if budget.destroy
        render json: budget, status: 200
      else
        render json: budget, status: 422
      end
    end

    private

    def bill_params
      params.require(:bill).permit(:budget_name, :monthly_spend, :goal, :user_id)
    end

end
