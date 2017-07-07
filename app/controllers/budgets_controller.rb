class BudgetsController < ApplicationController
    def budgets
      budgets = Budget.where(user_id:7)
      render json:budgets
    end

    def create
      @budget = Budget.new(
        budget_name: params["budget_name"],
        monthly_spend: params["monthly_spend"],
        goal: params["goal"],
        user_id: 7
      )
      if @budget.save
        render json: @budget, status: 200
      else
        render json: @budget.errors, status: 422
      end
    end

    def update

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
