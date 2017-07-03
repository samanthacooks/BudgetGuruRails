# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
credit_cards= ["American Express","Capital One","Discover","Bank of America","Credit One","JC Penney Credit Card","Kohl's Charge Card","Home Deport","Visa"]
loans = ["Sallie Mae","Great Lakes"]
goals = ["Italy","Aruba","TV","Shoes","Wedding"]
cable_tv= ["AT&T","Time Warner Cable","CenturyLink","Charter","Verizon","Cox"]
phone_providers= ["Verizon","AT&T","T-Mobile","Sprint","Cricket"]
bills = %w"Rent Phone Gas Light Insurance Gym Groceries CapitalOne"
status = %w"Paid Unpaid PastDue"
categories = %w(CreditCard Banks Loans Investments Internet&TV Phone Electricity&Gas Insurance Mortgage Water&Waste Rent Other)
company_names= [credit_cards.sample,loans.sample,cable_tv.sample,phone_providers.sample,"Google","Wegmans Food Markets","The Boston Consulting Group","Baird","Edward Jones","Genentech","Ultimate Software","Salesforce","Acuity","Quicken Loans"]

users = []
15.times do
  users << User.create(
  first_name:Faker::Name.first_name,
  last_name:Faker::Name.last_name,
  email:Faker::Internet.email,
  password:Faker::Internet.password,
  balance_floor:rand(300..1000),
  remaining_balance:0
  )
end


100.times do
  users.sample.bills.create(
    bill_name:bills.sample,
    amount:rand(20..1000),
    due_date:rand(Date.today..((Date.today)+(365*100))),
    status: status.sample,
    )

  users.sample.accounts.create(
    category:categories.sample,
    balance:0,
    company_name:company_names.sample
    )

  users.sample.incomes.create(
    source:company_names.sample,
    post_tax_amount: rand(0..1000),
    fixed:false,
    pay_schedule: ["monthly","weekly","bi-weekly","yearly"].sample
    )

  users.sample.budgets.create(
    budget_name:["Traveling","Entertainment","Shopping","Food","Technology"].sample,
    monthly_spend: 0,
    goal:false
    )

  Budget.all.sample.goals.create(
    goal_name: goals.sample,
    amount_saved:0,
    timeframe: rand(Date.today..((Date.today)+(365*100))),
    achieved:false,
    total: rand(0..1000)
    )
end
