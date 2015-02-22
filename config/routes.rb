Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :user

  resources :users, only: [:index, :show]
  resources :albums
end
