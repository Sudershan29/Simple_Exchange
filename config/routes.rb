Rails.application.routes.draw do
  resources :coin_requests
  resources :transactions
  resources :requests
  devise_for :users
  root 'home#index'
  get 'home/about'
  get 'home/market'
  resources :accounts

  put 'requests/:id/accept', to: 'requests#accept', as: 'accept'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
