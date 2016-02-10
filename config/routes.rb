Rails.application.routes.draw do
  
  resources :users
  
  root 'static_pages#home'
  get "/about", to: "static_pages#about"
  match "/help", to: "static_pages#help", via: "get"
  match "/singup", to: "users#new", via: "get"
  match "/singup", to: "users#create", via: "post"
  
  
end