Rails.application.routes.draw do
  root to: "posts#index"

  resources :posts, except: [:destroy] do
    member do
      post 'vote'
    end

    resources :comments, only: [:create] do
      member do
        post 'vote'
      end
    end
  end
  resources :categories, only: [:new, :show, :create]

  # Login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # Users
  resources :users, only: [:show, :create, :edit, :update]
  get '/register', to: 'users#new'

  # Two authen
  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'
end
