Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :users do
    resources :comments
    member do
      get :following, :followers
    end
  end
  resources :chables, only: [:create, :destroy] do
    resources :likes
    resources :comments
    member do
      get :rechable
    end
  end
  resources :comments do
    resources :comments
  end

  resources :connections,         only: [:create, :destroy]
end
