DrunkenBartender::Application.routes.draw do
  devise_for :users

    root to: "orders#index"

    resources :products
    resources :deliveries, except: [:show, :edit, :update]
    resources :users, only: :index
    resources :bookings, except: [:show, :edit, :update]
    resources :order_items, only: [:new, :create]
end
