class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    goals = Goal.where(user_id: 1)
    render json:goals
  end

  def show
  end

  # def new
  #   @budget = Budget.find_by(id: params[:id])
  #   @goal = Goal.new
  # end

  def create
    @goal = Goal.new(goal_name: params["goal_name"], amount_saved: params["amount_saved"], timeframe: params["timeframe"], achieved: params["achieved"], total: params["total"], budget_id: 1)
    if @goal.save
      render json: @goal, status 200
    else
      render json: @goal.errors, status 422
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def goal_params
    params.require(:goals).permit(:goal_name,:amount_saved,:timeframe,:achieved,:total,:budget_id)
  end
end
