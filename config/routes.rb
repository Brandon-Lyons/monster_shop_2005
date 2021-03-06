Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index", as: :root

  namespace :merchant do
    get "/", to: "dashboard#index", as: :dashboard
    get "/items", to: "items#index", as: :items
  end

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update", as: :merchant_update
  delete "/merchants/:id", to: "merchants#destroy"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update", as: :item_update
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  patch "/cart/:item_id", to: "cart#increase_quantity"
  put "/cart/:item_id", to: "cart#decrease_quantity"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show", as: :order_show
  patch "/orders/:id", to: "orders#update"

  resources :users, only: [:create]

  get "/register", to: "users#new"
  get "/profile", to: "users#show"
  get "profile/edit", to: "users#edit"
  patch "profile/edit", to: "users#update"
  get "/profile/orders", to: "users/orders#index", as: :profile_orders
  get "/profile/orders/:id", to: "orders#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  get "/logout", to: "sessions#destroy"

  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard
    get "/merchants/:merchant_id", to: "dashboard#merchant", as: :dashboard_merchant
    get "/merchants/:merchant_id/items", to: "dashboard#merchant_items", as: :dashboard_merchant_items
  end

  scope :admin do
    get "/merchants", to: "merchants#index", as: :admin_merchants
  end

  resources :admin, only: [:index]
end
