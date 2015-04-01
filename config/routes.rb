Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :user, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => 'users/registrations' }

  resources :users, only: [:index, :show]
  resources :albums do
    resources :photos
  end

  resources :users do
    get '/shared_albums', to: 'album_viewers#index'
  end
end
