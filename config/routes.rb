Consumo::Application.routes.draw do
  devise_for :users

    root to: "order_items#new"

    resources :statistics
    resources :orders
    resources :skus
    resources :categories
    resources :products
    resources :deliveries, except: [:show, :edit, :update]
    resources :users, only: [:index, :edit], via: [:get, :post] do
      collection do
        match 'search' => 'users#search', via: [:get, :post], as: :search  
        patch 'update_password'
      end
    end
    resources :bookings, except: [:show, :edit, :update]
    resources :order_items, only: [:new, :create]
end
