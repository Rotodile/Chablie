Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  get 'search' => 'search#index'
  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :connections,         only: [:create, :destroy]
  resources :comments do
    resources :comments
  end
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
end
