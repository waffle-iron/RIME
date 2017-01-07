Rails.application.routes.draw do
  root 'welcome#welcome'

  get '/signup', to: 'users#new'
  get 'welcome/welcome'

  resources :users
end
