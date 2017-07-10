class GoalsController < ApplicationController
  def index
    user = User.find_by(id:1)
    goals = user.goals

      if goals.empty?
        array = 0
      end

    goals = {
      array: array,
      status:user.positive,
      goals: Budget.where(user_id:1)
    }
    render json: goals
  end

  def create
    goal = Goal.new(
    goal_name: params["user"]["goal_name"],
    amount_saved: params["user"]["amount_saved"],
    timeframe: params["user"]["timeframe"],
    achieved: params["user"]["achieved"],
    total: params["user"]["total"],
    budget_id: 1
    )

    if goal.save
      render json: goal, status: 200
    else
      render json: goal.errors, status: 422
    end
  end

  def update
  end

  def destroy
    goal = Goal.find_by(id:params[:id]).destroy
    render json: goal
  end

  private

  def goal_params
    params.require(:goals).permit(:goal_name,:amount_saved,:timeframe,:achieved,:total,:budget_id)
  end
end
