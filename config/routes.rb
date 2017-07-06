Rails.application.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'verify'  => 'sessions#verify_access_token'
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]


  get '/bills/all' => 'bills#allbills'
  post '/bills/new' => 'bills#create'
  post '/bills/update' => 'bills#update'
  delete '/bills/delete' => 'bills#destroy'

  get '/budgets' => 'budgets#budgets'
  post '/budgets/new' => 'budgets#create'
  post '/budgets/update' => 'budgets#update'
  delete '/budgets/delete' => 'budgets#destroy'

  get '/accounts/all' => 'accounts#index'
  post '/accounts/new' => 'accounts#create'
  post '/accounts/update' => 'accounts#update'
  delete '/accounts/delete' => 'accounts#destroy'

  resources :accounts do
    resources :goals, only: [:new, :create]
  end

  get '/goals/all' => 'goals#index'
  post '/goals/new' => 'goals#create'
  post '/goals/update' => 'goals#update'
  delete '/goals/delete' => 'goals#destroy'

  root 'users#new'
end
