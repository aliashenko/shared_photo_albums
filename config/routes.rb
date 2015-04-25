Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :user,
             :controllers => { omniauth_callbacks: 'omniauth_callbacks',
                               registrations: 'users/registrations' },
             :skip => [:sessions]

  as :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :users, only: [:index, :show]
  resources :albums do
    resources :photos
  end
  resources :share_album do
    member do
      get 'viewers'
    end
  end

  resources :users do
    get '/shared_albums', to: 'album_viewers#index'
  end
end
