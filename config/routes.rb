Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :chables,             only: [:create, :destroy]
  resources :connections,         only: [:create, :destroy]
end
