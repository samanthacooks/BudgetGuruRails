class CalculationsController < ApplicationController
  USER = User.find_by(id:1)

  def total_bills
    USER.bills.sum(:amount)
  end

  def total_income
    USER.incomes.where(fixed: true).sum(:post_tax_amount)*12
  end

  def total_expenses_for_the_year
    recurring_expenses = USER.bills.where(recurring:true).sum(:amount)*12
    one_time_expenses = USER.bills.where(recurring: false).sum(:amount)
    recurring_expenses + one_time_expenses
  end

  def remaining_balance
    total_account_balance = USER.accounts.sum(:balance)
    USER.update_attribute(:remaining_balance, (total_account_balance - total_bills) )
    USER.remaining_balance
  end

  def user_status
    if remaining_balance < 0
      USER.update_attribute(:positive, true)
    else
      USER.update_attribute(:positive, false)
    end
  end

  def average_monthly_available_spend
    year_spend_budgets = (total_budgets_amount)*12

    ((total_income - total_expenses_for_the_year)-year_spend_budgets)/12
  end

  def total_available_spend_for_the_year
    (total_income - total_expenses_for_the_year)
  end

  def total_budgets_amount
    USER.budgets.sum(:monthly_spend)
  end


  def summary
    message = ""

    floor = USER.balance_floor

    if USER.positive
      message = "You are $#{floor+ (-(remaining_balance))} away from meeting you minimum floor of $#{floor}"
    else
      message = "You are $#{floor+ (-(remaining_balance))} above your floor of $#{floor}"
    end

    summary = {
      remaining_balance: remaining_balance,
      negative?: user_status,
      message: message,
      total_expenses: total_expenses_for_the_year,
      total_income: total_income,
      year_spend: total_available_spend_for_the_year,
      average_monthly_available_spend: average_monthly_available_spend,
      total_budgets_amount: total_budgets_amount
    }

    render json: summary
  end

  def expense
    USER.update_attribute()
  end
end
