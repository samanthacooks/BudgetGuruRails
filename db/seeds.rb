hector = User.create(
first_name:"Hector",
last_name:"Feurtado",
email:"HectorFeurtado@gmail.com",
password:"password",
balance_floor:1000
)

hector.bills.create(
  bill_name:"Daycare",
  amount:256,
  due_date:15,
  status: "false"
)

hector.bills.create(
  bill_name:"Spotify",
  amount:15,
  due_date: 12,
  status: "false"
)

hector.bills.create(
  bill_name:"Cell Phone",
  amount:92,
  due_date:4,
  status: "false"
)

hector.bills.create(
  bill_name:"Groceries",
  amount:300,
  due_date:20,
  status: "false"
)

hector.bills.create(
  bill_name:"Capital One Credit card",
  amount:300,
  due_date:4,
  status: "false"
)
hector.bills.create(
  bill_name:"Sallie Mae",
  amount:350,
  due_date:11,
  status: "false"
)
hector.bills.create(
  bill_name:"Great Lakes Student Loan",
  amount:250,
  due_date:18,
  status: "false"
)
hector.bills.create(
  bill_name:"DBC Loan",
  amount:250,
  due_date:14,
  status: "false"
)
hector.bills.create(
  bill_name:"Progressive Insurance",
  amount:90,
  due_date:15,
  status: "false"
)
hector.bills.create(
  bill_name:"Rent",
  amount:900,
  due_date:15,
  status: "false"
)
hector.bills.create(
  bill_name:"Light Bill",
  amount:65,
  due_date:8,
  status: "false"
)
hector.bills.create(
  bill_name:"Electricity Bill",
  amount:90,
  due_date:15,
  status: "false"
)


hector.accounts.create(
  type:"Checkings Account",
  balance: 500,
  bank_name:"Peoples Bank"
)

hector.accounts.create(
  type:"Checkings Account",
  balance:300,
  bank_name:"TD Bank"
)

hector.incomes.create(
  source:"DBC Company",
  post_tax_amount: 4000,
  fixed:"true",
  pay_schedule: "monthly"
)

hector.incomes.create(
  source:"ABC Company",
  post_tax_amount: 1200,
  fixed:"false",
  pay_schedule: "monthly"
)


budget1 = hector.budgets.create(
  budget_name:"Technology",
  monthly_spend: 0,
  goal:false
  )

budget2 = hector.budgets.create(
  budget_name:"Traveling",
  monthly_spend: rand(10..1000),
  goal:false
)

budget1.goals.create(
  goal_name: "Yamaha Motif",
  amount_saved:20,
  timeframe: rand(Date.today..((Date.today)+(365))),
  achieved:false,
  total: 3500
)

budget2.goals.create(
  goal_name: "Bora Bora",
  amount_saved:300,
  timeframe: rand(Date.today..((Date.today)+(365))),
  achieved:false,
  total: 3500
)
