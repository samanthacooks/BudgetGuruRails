Rails.application.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'verify'  => 'sessions#verify_access_token'
  post '/update/:token' => 'users#update'
  get '/users/:token/edit' => 'users#edit'
  resources :users, only: [:show, :new, :create, :update, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get '/incomes/:token' => 'incomes#index'
  post '/incomes/:token' => 'incomes#create'
  post '/incomes/update/:token' => 'incomes#update'
  delete '/incomes' => 'incomes#destroy'


  get '/bills/:token' => 'bills#allbills'
  post '/bills/new/:token' => 'bills#create'
  post '/bills/update/:token' => 'bills#update'
  delete '/bills' => 'bills#destroy'

  get '/budgets/:token' => 'budgets#budgets'
  post '/budgets/new/:token' => 'budgets#create'
  post '/budgets/update/:token' => 'budgets#update'
  delete '/budgets' => 'budgets#destroy'

  get '/accounts' => 'accounts#index'
  post '/accounts/new/:token' => 'accounts#create'
  post '/accounts/update/:token' => 'accounts#update'
  delete '/accounts/delete/:token' => 'accounts#destroy'

  resources :accounts do
    resources :goals, only: [:new, :create]
  end

  get '/calculate/:num' => 'calculations#calculate'

  get '/goals/:token' => 'goals#index'
  post '/goals/new' => 'goals#create'
  post '/goals/update' => 'goals#update'
  delete '/goals' => 'goals#destroy'

  get '/summary' => 'calculations#summary'
  post '/expense' => 'calculations#create'

  root 'users#new'
end
