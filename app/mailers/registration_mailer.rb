class RegistrationMailer < ApplicationMailer
  default from: "registration@budgetguru.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to BudgetGuru!')
  end
end
