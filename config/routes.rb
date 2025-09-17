Rails.application.routes.draw do
  get 'sessions/new'
  get 'reservations/index'
  get 'rooms/index'
  get 'users/index'
  root 'rooms#index'

  resources :rooms do
    collection do
      get 'search'
    end
  end

  resources :reservations
  resources :rooms
  resources :users

  get '/login',  to: 'sessions#new'
  post  '/login',  to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy', as: 'logout'
  
  resources :users, only: [] do
    member do
      get 'show_account'
      get 'edit_account'
      patch 'update_account'
      get 'show_profile'
      get 'edit_profile'
      patch 'update_profile'
      get 'show_user_reservations'
    end
  end

  resources :rooms, only: [] do
    member do
      get 'show_user_facility'
      get 'show_room'
      get 'edit_room'
      get 'detail_room'
    end

      resources :reservations, only: [:create] do
        collection do
          post 'confirm'
          get 'confirm'
        end 
      end
  end
end