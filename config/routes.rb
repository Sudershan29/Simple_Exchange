Rails.application.routes.draw do
  resources :coin_requests
  resources :transactions
  resources :requests
  devise_for :users
  root 'home#index'
  get 'home/about'
  get 'home/market'
  get 'home/coin_market'
  resources :accounts

  put 'requests/:id/accept', to: 'requests#accept', as: 'accept'
  put 'requests/:id/accept2', to: 'requests#accept2', as: 'accept2'
  put 'coin_requests/:id/coin_accept', to: 'coin_requests#coin_accept', as: 'coin_accept'
  put 'coin_requests/:id/coin_accept2', to: 'coin_requests#coin_accept2', as: 'coin_accept2'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
