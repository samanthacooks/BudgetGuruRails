class CalculationsController < ApplicationController
  USER = User.find_by(id:1)

  def total_bills
    USER.bills.where(status:"paid").sum(:amount)
  end

  def current_week
    Date.today.strftime("%U").to_i
  end

  def total_income
    USER.incomes.where(fixed: true).sum(:post_tax_amount)*months_left
  end

  def weeks_left
    52 - current_week
  end

  def months_left
    12 - Time.now.month
  end

  def total_expenses_for_the_year
    recurring_expenses = USER.bills.where(recurring:true).sum(:amount)*months_left
    one_time_expenses = USER.bills.where(recurring: false).sum(:amount)
    recurring_expenses + one_time_expenses
  end

  def remaining_balance
    total_account_balance = USER.accounts.sum(:balance)
    USER.update_attribute(:remaining_balance, (total_account_balance - total_bills) )

    #always show the user their balance minus the balance_floor
    USER.remaining_balance - USER.balance_floor
  end

  def total_income_by(schedule)
    USER.incomes.where(fixed: true , pay_schedule: schedule).sum(:post_tax_amount)
  end

  #this method will automatically"withdraw" from the users account the amount for the bill paid
  def remaining_balance_after_charge_account
    balance = remaining_balance
    bills = USER.bills

    bills.each do |bill|
      if bill.status == "paid"
        balance = balance - bill.amount
      end
    end
    balance
  end

  def put_money_towards_goal

  end

  #this method will automatically "deposit" money for the user. It will update their bank account based on their pay schedule.
  def deposit_money
    user_accounts = USER.accounts

    user_accounts.each do |account|
    week_of_last_deposit = account.updated_at.strftime("%U").to_i

      if current_week - week_of_last_deposit == 1
        account.update_attribute(:balance, account.balance + total_income_by("weekly"))

      elsif current_week - week_of_last_deposit == 2
        account.update_attribute(:balance, account.balance + total_income_by("bi-weekly"))

      elsif current_week - week_of_last_deposit == 30
        account.update_attribute(:balance, account.balance + total_income_by("monthly"))
      end
    end
  end

  def user_status
    if remaining_balance < 0 == false
      USER.update_attribute(:positive, true)
    else
      USER.update_attribute(:positive, false)
    end
    return USER.positive
  end

  def average_monthly_available_spend
    year_spend_budgets = (total_budgets_amount)*months_left

    ((total_income - total_expenses_for_the_year)-year_spend_budgets)/months_left
  end

  def total_available_spend_for_the_year
    (total_income - total_expenses_for_the_year)
  end

  def total_budgets_amount
    USER.budgets.sum(:monthly_spend)
  end


  def summary
    deposit_money
    message = ""

    floor = USER.balance_floor

    if USER.positive == true && remaining_balance < floor
      message = "In the green!, But you're below your desired minimum balance by $#{floor-remaining_balance}"
    elsif USER.positive == true && remaining_balance > floor
      message = "Whoa! Looking Good!"
    elsif USER.positive == false && remaining_balance < floor
      message = "It's time for you to set your priorities straight"
    end

    summary = {
      remaining_balance: remaining_balance_after_charge_account,
      positive?: user_status,
      message: message,
      total_income: total_income,
      total_expenses: total_expenses_for_the_year,
      year_spend: total_available_spend_for_the_year,
      average_monthly_available_spend: average_monthly_available_spend,
      total_budgets_amount: total_budgets_amount,
      floor: USER.balance_floor
    }

    render json: summary
  end

  def expense
    USER.update_attribute()
  end
end
