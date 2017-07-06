Rails.application.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'verify'  => 'sessions#verify_access_token'
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]


  get '/bills/all' => 'bills#allbills'
  post '/bills/new' => 'bills#create'


  root 'users#new'
end
