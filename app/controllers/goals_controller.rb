class GoalsController < ApplicationController
  def index
    user = User.find_by(access_token:params[:token])
    goals = user.goals

      if goals.empty?
        array = 0
      end

    goals = {
      array: array,
      status:user.positive,
      goals: user.goals
    }
    render json: goals
  end

  def create
    user = User.find_by(access_token:params[:token])
    goal = Goal.new(
      goal_name: params[:goal_name],
      amount_saved: params[:amount_saved],
      timeframe: params[:time_frame],
      total: params[:total],
      budget_id: params[:id]
    )
    if goal.save
      render json: goal, status: 200
    else
      render json: goal.errors, status: 422
    end
  end

  def update
    goal = Goal.find_by(id:params[:id]).update_attributes(
      goal_name: params[:goal_name],
      amount_saved: params[:amount_saved],
      timeframe: params[:time_frame],
      total: params[:total],
      budget_id: params[:budget_id]
    )
    render json: goal, status: 200
  end

  def destroy
    goal = Goal.find_by(id:params[:id]).destroy
    render json: goal
  end

  private

  def goal_params
    params.require(:goals).permit(:amount_saved,:timeframe,:total,:budget_id)
  end
end
