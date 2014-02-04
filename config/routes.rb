TttApp::Application.routes.draw do
  
  resources :ttts
  get '/all_ttts', to: "ttts#all_ttts"
  post '/ttts/:id', to: "ttts#update", as: :update 
  get '/ttts/comp/:id', to: "ttts#play_comp", as: :play_comp 

  resources :users

  root to: "games_lists#index"

  get "/login", to: "sessions#create", as: :login

  get '/logout', to: "sessions#destroy", as: :logout
  root to: 'ttts#index'

  resources :sessions
end
