Consumo::Application.routes.draw do
  devise_for :users

  resources :skus
  resources :categories
  resources :realms

  resources :users, only: [:index, :edit] do
    collection do
      match 'search' => 'users#search', via: [:get, :post], as: :search
      patch 'update_password'
    end
  end

  resources :products do
    collection do
      match 'search' => 'products#search', via: [:get, :post], as: :search
    end
  end

  namespace :statistics do
    resources :orders do
      collection do
        match 'search' => 'statistics_orders#search', via: [:get, :post], as: :search
      end
    end
    resources :popularity do
      collection do
        match 'search' => 'statistics_popularity#search', via: [:get, :post], as: :search
      end
    end
  end

  resources :orders do
    collection do
      match 'search' => 'orders#search', via: [:get, :post], as: :search
    end
  end

  resources :bookings do
    collection do
      match 'search' => 'bookings#search', via: [:get, :post], as: :search
    end
  end

  resources :deliveries do
    collection do
      match 'search' => 'deliveries#search', via: [:get, :post], as: :search
    end
  end

  resources :deliveries, except: [:show, :edit, :update]
  resources :order_items, only: [:new, :create]

  resources :realms, except: :delete


  get ':selected_realm', to: 'order_items#new'
  root to: 'order_items#new'
end
