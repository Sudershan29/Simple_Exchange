Rails.application.routes.draw do
  resources :transactions
  resources :requests
  devise_for :users
  root 'home#index'
  get 'home/about'
  get 'home/market'
  resources :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
