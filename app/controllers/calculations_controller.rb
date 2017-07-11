class CalculationsController < ApplicationController
  def convert_number_to_date(due_date)
    today = Date.today
    bill_due_date = nil

    if today.day >= due_date
        #this will convert the(hypothetically speaking) day number (15) to "2017-07-15"
        bill_due_date = (today -(today.day-due_date))
      elsif today.day < due_date
        bill_due_date = (today +(due_date-today.day))
    end
    bill_due_date
  end


#this method will only show the users bills that have not been paid. And bills that are within a week of the due_date
  def bills_upcoming
    today = Date.today
    bills = $USER.bills.where(status: "not paid")
    upcoming_bills = []

    bills.each do |bill|
      if today > convert_number_to_date(bill.due_date)
        bill.update_attribute(:status, "past due")
        upcoming_bills << bill
      end
      if today < convert_number_to_date(bill.due_date) && bill.due_date - today.day <= 14
        upcoming_bills << bill
      end
    end
    upcoming_bills
  end

  def bills_upcoming_total
    bills_upcoming.reduce(0) {|sum,bill| sum+bill.amount}
  end

  def bills_upcoming_count
    bills_upcoming.count
  end

  def total_bills
    $USER.bills.sum(:amount)
  end

  def total_expenses
    $USER.expenses.sum(:amount)
  end

  def current_week
    Date.today.strftime("%U").to_i + 31
  end

  def total_income
    $USER.incomes.where(fixed: true).sum(:post_tax_amount)*months_left
  end

  def weeks_left
    52 - current_week
  end

  def months_left
    12 - Time.now.month
  end

  def total_expenses_for_the_year
    (total_bills * months_left)+ total_expenses
  end

  def remaining_balance
    total_account_balance = $USER.accounts.sum(:balance)
    $USER.update_attribute(:remaining_balance, (total_account_balance - total_bills - total_expenses))
    $USER.remaining_balance
  end

  def total_income_by(schedule)
    $USER.incomes.where(fixed: true , pay_schedule: schedule).sum(:post_tax_amount)
  end

  #this method will automatically"withdraw" from the users account the amount for the bill paid
  def remaining_balance_after_charge_account
    balance = remaining_balance
    bills = $USER.bills

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
    user_accounts = $USER.accounts

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
      $USER.update_attribute(:positive, true)
    else
      $USER.update_attribute(:positive, false)
    end
    return $USER.positive
  end

  def average_monthly_available_spend
    year_spend_budgets = (total_budgets_amount)*months_left

    ((total_income - total_expenses_for_the_year)-year_spend_budgets)/months_left
  end

  def total_available_spend_for_the_year
    (total_income - total_expenses_for_the_year)
  end

  def total_budgets_amount
    $USER.budgets.sum(:monthly_spend)
  end

  def can_spend?
    ((remaining_balance_after_charge_account + total_income_by("weekly")) - bills_upcoming_total)>0
  end


  def summary
    # $USER = User.find_by(access_token:params[:token])
    # binding.pry

    default_messages=["Nice! Now let's go shopping! No really, you can treat yourself to something this week. But remember to use our calculator 😉","What are you getting me? 😁"]
    deposit_money
    message = ""

    floor = $USER.balance_floor
    if $USER.positive == true && !can_spend?
      message = "You have #{bills_upcoming_count} bills coming up within the next week totaling $#{bills_upcoming_total}. You get paid $#{total_income_by('weekly')} next week from your fixed income. You'll still be short $#{(remaining_balance_after_charge_account + total_income_by('weekly'))-bills_upcoming_total}"
    elsif $USER.positive == true && remaining_balance > floor && can_spend?
      message = default_messages.sample
    elsif $USER.positive == true && remaining_balance < floor && can_spend?
      message = "You dont have any upcoming bills within the next week but your account is below your desired minimum by $#{floor-remaining_balance}"
    elsif $USER.positive == false && remaining_balance < floor
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
      floor: $USER.balance_floor,
      bills_upcoming: bills_upcoming_total,
      can_spend: can_spend?,
      weekly:total_income_by("weekly")
    }

    render json: summary
  end

  def create
    remaining_balance_after_charge_account = (remaining_balance_after_charge_account - params["amount"].to_i)
    expense = $USER.expenses.new(
    amount:params["amount"].to_i,
    user_id: $USER.id
    )
    if expense.save
      render json: expense, status: 200
    else
      render json: expense.errors, status: 422
    end
  end

end
