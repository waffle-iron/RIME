Rails.application.routes.draw do
  root 'welcome#welcome'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get 'welcome/welcome'

  resources :users
end
