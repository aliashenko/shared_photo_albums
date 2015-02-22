Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :user

  resources :albums
end
