Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'welcome#welcome'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get 'users/signup_success'

  get 'welcome/welcome'

  resources :users
  resources :account_activations, only: [:edit]    #Only providing an Edit route for this resource.
  resources :password_resets, only: [:new, :edit, :create, :update]
end
