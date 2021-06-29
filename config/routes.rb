Rails.application.routes.draw do
  root to: "posts#index"

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
  resources :categories, only: [:new, :show, :create]
  # Login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # Register new users
  resources :users, only: [:show, :create, :edit, :update]
  get '/register', to: 'users#new'
end
