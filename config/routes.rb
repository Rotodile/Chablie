Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'pages#home'
  get '/about', to: 'pages#about'
  get '/signup', to: 'users#new'
  get 'search' => 'search#index'
  get '/messages', to: 'chats#index'
  get 'mentions', to: 'users#mentions'
  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :connections,         only: [:create, :destroy]
  resources :messages, only:[:create]
  resources :comments do
    resources :comments
  end
  resources :users do
    resources :chats, only: [:index, :show, :create]
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
